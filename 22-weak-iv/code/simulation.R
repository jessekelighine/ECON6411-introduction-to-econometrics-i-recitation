#!/usr/bin/env Rscript

library(ggplot2)

set.seed(2026)

n <- 500
reps <- 20000
beta <- 1
rho <- 0.9

# (e_i, u_i) jointly normal with unit variances and correlation rho
draw_errors <- function(n, reps) {
  u <- matrix(rnorm(n * reps), nrow = n)
  e <- rho * u + sqrt(1 - rho^2) * matrix(rnorm(n * reps), nrow = n)
  list(e = e, u = u)
}

# Demeaning partials out the intercept, the only included exogenous regressor
center <- function(A) sweep(A, 2, colMeans(A))

# Histogram densities on a fixed window, normalized by the total number of draws,
# so heavy tails outside the window are not rescaled into it
binned_density <- function(draws, breaks) {
  counts <- table(cut(draws, breaks))
  data.frame(
    x = head(breaks, -1) + diff(breaks) / 2,
    density = as.numeric(counts) / (length(draws) * diff(breaks))
  )
}

# ---------------------------------------------------------------------------
# Part 1: one instrument and an intercept, x = mu z / sqrt(n) + u
# ---------------------------------------------------------------------------

simulate_just_identified <- function(mu) {
  z <- center(matrix(rnorm(n * reps), nrow = n))
  errors <- draw_errors(n, reps)
  x <- center(z * mu / sqrt(n) + errors$u)
  y <- center(x * beta + errors$e)

  szz <- colSums(z * z)
  szx <- colSums(z * x)
  szy <- colSums(z * y)

  beta_iv <- szy / szx
  sigma2_e <- colSums((y - sweep(x, 2, beta_iv, `*`))^2) / n
  t_stat <- (beta_iv - beta) / sqrt(sigma2_e * szz / szx^2)

  gamma_hat <- szx / szz
  sigma2_u <- colSums((x - sweep(z, 2, gamma_hat, `*`))^2) / (n - 2)
  first_stage_f <- gamma_hat^2 * szz / sigma2_u

  r <- y - x * beta
  szr <- colSums(z * r)
  explained <- szr^2 / szz
  ar <- explained / ((colSums(r * r) - explained) / (n - 2))

  data.frame(
    mu = mu,
    scaled_error = mu * (beta_iv - beta),
    t_stat = t_stat,
    first_stage_f = first_stage_f,
    ar = ar
  )
}

# Staiger-Stock limit of mu (beta_iv - beta): mu xi_e / (mu + xi_u)
weak_iv_limit <- function(mu, draws = 1e6) {
  xi_u <- rnorm(draws)
  xi_e <- rho * xi_u + sqrt(1 - rho^2) * rnorm(draws)
  mu * xi_e / (mu + xi_u)
}

just_identified <- lapply(c(1, 10), simulate_just_identified)

breaks <- seq(-4, 4, by = 0.1)
grid <- seq(-4, 4, length.out = 401)

histograms <- do.call(rbind, lapply(just_identified, function(sim) {
  cbind(mu = sim$mu[1], binned_density(sim$scaled_error, breaks))
}))
curves <- do.call(rbind, lapply(c(1, 10), function(mu) {
  rbind(
    data.frame(mu = mu, x = grid, density = dnorm(grid), curve = "N(0, 1)"),
    cbind(
      mu = mu,
      binned_density(weak_iv_limit(mu), breaks),
      curve = "Weak-IV limit"
    )
  )
}))

plot_iv <- ggplot() +
  geom_col(
    data = histograms,
    aes(x = x, y = density),
    width = 0.1,
    fill = "gray85",
    colour = "gray60",
    linewidth = 0.2
  ) +
  geom_line(
    data = curves,
    aes(x = x, y = density, colour = curve, linetype = curve),
    linewidth = 0.8
  ) +
  facet_wrap(~mu, labeller = label_bquote(mu == .(mu))) +
  scale_colour_manual(
    name = NULL,
    values = c("N(0, 1)" = "blue", "Weak-IV limit" = "red")
  ) +
  scale_linetype_manual(
    name = NULL,
    values = c("N(0, 1)" = "solid", "Weak-IV limit" = "dashed")
  ) +
  labs(x = expression(mu * (hat(beta)[IV] - beta)), y = "Density") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave("iv-distribution.pdf", plot_iv, width = 8, height = 4)

# ---------------------------------------------------------------------------
# Part 2: q = 10 instruments, 2SLS and LIML as k-class estimators
# ---------------------------------------------------------------------------

q <- 10
concentration <- 10

# k-class estimator from 2 x 2 moment matrices of W = [y, x]
k_class <- function(WW, WMW, kappa) {
  A <- WW - kappa * WMW
  A[2, 1] / A[2, 2]
}

simulate_over_identified <- function() {
  # gamma_2 = c / sqrt(n) with equal components and c'c = concentration
  gamma <- rep(sqrt(concentration / q), q) / sqrt(n)
  results <- matrix(NA_real_, nrow = reps, ncol = 6)
  for (rep in seq_len(reps)) {
    Z <- center(matrix(rnorm(n * q), nrow = n))
    errors <- draw_errors(n, 1)
    x <- Z %*% gamma + errors$u
    y <- x * beta + errors$e
    W <- center(cbind(y, x))

    ZW <- crossprod(Z, W)
    WW <- crossprod(W)
    WPW <- crossprod(ZW, solve(crossprod(Z), ZW))
    WMW <- WW - WPW

    kappa_liml <- min(Re(eigen(solve(WMW, WW), only.values = TRUE)$values))
    estimates <- c(
      tsls = k_class(WW, WMW, 1),
      liml = k_class(WW, WMW, kappa_liml)
    )

    # Conventional t statistics: sigma2 (x'(I - kappa M_Z) x)^{-1}
    t_stats <- sapply(c(tsls = 1, liml = kappa_liml), function(kappa) {
      b <- k_class(WW, WMW, kappa)
      a <- c(1, -b)
      sigma2 <- sum(a * (WW %*% a)) / n
      (b - beta) / sqrt(sigma2 / (WW[2, 2] - kappa * WMW[2, 2]))
    })

    a0 <- c(1, -beta)
    ar <- (sum(a0 * (WPW %*% a0)) / q) / (sum(a0 * (WMW %*% a0)) / (n - q - 1))
    first_stage_f <- (WPW[2, 2] / q) / (WMW[2, 2] / (n - q - 1))

    results[rep, ] <- c(estimates[c("tsls", "liml")], t_stats, ar, first_stage_f)
  }
  colnames(results) <- c("tsls", "liml", "t_tsls", "t_liml", "ar", "first_stage_f")
  as.data.frame(results)
}

over_identified <- simulate_over_identified()

estimator_breaks <- seq(-1.5, 1.5, by = 0.025)
estimator_densities <- rbind(
  cbind(
    estimator = "2SLS",
    binned_density(over_identified$tsls - beta, estimator_breaks)
  ),
  cbind(
    estimator = "LIML",
    binned_density(over_identified$liml - beta, estimator_breaks)
  )
)

plot_k_class <- ggplot(
  estimator_densities,
  aes(x = x, y = density, colour = estimator)
) +
  geom_step(direction = "mid", linewidth = 0.7) +
  geom_vline(
    aes(xintercept = value, linetype = label),
    data = data.frame(
      value = c(0, rho),
      label = c("True value", "OLS probability limit")
    ),
    key_glyph = "path"
  ) +
  scale_colour_manual(
    name = NULL,
    values = c("2SLS" = "blue", "LIML" = "red")
  ) +
  scale_linetype_manual(
    name = NULL,
    values = c("True value" = "solid", "OLS probability limit" = "dashed"),
    breaks = c("True value", "OLS probability limit")
  ) +
  labs(x = expression(hat(beta) - beta), y = "Density") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave("liml-vs-2sls.pdf", plot_k_class, width = 8, height = 4)

# ---------------------------------------------------------------------------
# Rejection rates of nominal 5% tests of H0: beta = 1 (true)
# ---------------------------------------------------------------------------

rejection_rates <- rbind(
  do.call(rbind, lapply(just_identified, function(sim) {
    data.frame(
      design = paste0("q = 1, mu = ", sim$mu[1]),
      mean_first_stage_f = mean(sim$first_stage_f),
      reject_t = mean(abs(sim$t_stat) > qnorm(0.975)),
      reject_t_liml = NA,
      reject_ar = mean(sim$ar > qf(0.95, 1, n - 2))
    )
  })),
  data.frame(
    design = paste0("q = ", q, ", lambda = ", concentration),
    mean_first_stage_f = mean(over_identified$first_stage_f),
    reject_t = mean(abs(over_identified$t_tsls) > qnorm(0.975)),
    reject_t_liml = mean(abs(over_identified$t_liml) > qnorm(0.975)),
    reject_ar = mean(over_identified$ar > qf(0.95, q, n - q - 1))
  )
)

median_bias <- c(
  tsls = median(over_identified$tsls) - beta,
  liml = median(over_identified$liml) - beta
)

print(rejection_rates, digits = 4)
cat("Median bias, 2SLS:", median_bias["tsls"], "\n")
cat("Median bias, LIML:", median_bias["liml"], "\n")

write.csv(rejection_rates, "rejection-rates.csv", row.names = FALSE)
