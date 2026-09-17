# G6411 Recitation: Prerequisite Review Questions and Answers

## 1. Probability and Statistics

### 1.1 Random Variable

Suppose a fair coin produces the value $1$ after heads and $-1$ after tails.

#### (a) What is the sample space?

The sample space is

$$
\Omega=\{H,T\}.
$$

#### (b) What are all possible events?

Taking the event space to be the power set of $\Omega$,

$$
\mathcal F=2^\Omega
=\{\varnothing,\{H\},\{T\},\{H,T\}\}.
$$

#### (c) What is the probability of each event?

Because the coin is fair,

$$
P(\varnothing)=0,
\qquad
P(\{H\})=\frac12,
\qquad
P(\{T\})=\frac12,
\qquad
P(\Omega)=1.
$$

#### (d) What is a random variable? Define $X$.

A real-valued random variable is a measurable function from the sample space to $\mathbb R$. Here,

$$
X:\Omega\to\mathbb R,
\qquad
X(\omega)=
\begin{cases}
1,&\omega=H,\\
-1,&\omega=T.
\end{cases}
$$

The elementary outcome is $H$ or $T$; the random variable assigns a number to that outcome.

### 1.2 Joint, Marginal, and Conditional Distributions

The joint probability mass function is

|       | $Y=0$ | $Y=1$ |
|------:|:-------:|:-------:|
| $X=0$ | $0.10$ | $0.20$ |
| $X=1$ | $0.30$ | $0.40$ |

#### (a) Verify that this is a valid joint distribution.

Every entry is nonnegative, and

$$
0.10+0.20+0.30+0.40=1.
$$

Therefore, the table is a valid joint probability mass function.

#### (b) Find the marginal distributions of $X$ and $Y$.

Sum across the possible values of the other variable:

$$
\begin{aligned}
P(X=0)&=0.10+0.20=0.30,\\
P(X=1)&=0.30+0.40=0.70,
\end{aligned}
$$

and

$$
\begin{aligned}
P(Y=0)&=0.10+0.30=0.40,\\
P(Y=1)&=0.20+0.40=0.60.
\end{aligned}
$$

Thus, $X\sim\operatorname{Bernoulli}(0.7)$ and $Y\sim\operatorname{Bernoulli}(0.6)$.

#### (c) Find $P(X=1\mid Y=1)$ and $P(Y=1\mid X=0)$.

Using $P(A\mid B)=P(A\cap B)/P(B)$,

$$
P(X=1\mid Y=1)
=\frac{P(X=1,Y=1)}{P(Y=1)}
=\frac{0.40}{0.60}
=\frac23,
$$

and

$$
P(Y=1\mid X=0)
=\frac{P(X=0,Y=1)}{P(X=0)}
=\frac{0.20}{0.30}
=\frac23.
$$

#### (d) Compute the means and variances of $X$ and $Y$.

Because $X,Y\in\{0,1\}$, we have $X^2=X$ and $Y^2=Y$. Therefore,

$$
E[X]=0(0.30)+1(0.70)=0.70,
\qquad
E[X^2]=0.70,
$$

so

$$
\operatorname{Var}(X)
=E[X^2]-E[X]^2
=0.70-0.70^2
=0.21.
$$

Similarly,

$$
E[Y]=0.60,
\qquad
E[Y^2]=0.60,
$$

and hence

$$
\operatorname{Var}(Y)
=0.60-0.60^2
=0.24.
$$

#### (e) Compute the covariance. Are $X$ and $Y$ independent?

Only the outcome $(X,Y)=(1,1)$ contributes to $E[XY]$, so

$$
E[XY]=1\cdot1\cdot P(X=1,Y=1)=0.40.
$$

Therefore,

$$
\operatorname{Cov}(X,Y)
=E[XY]-E[X]E[Y]
=0.40-(0.70)(0.60)
=-0.02.
$$

The variables are not independent. For example,

$$
P(X=1,Y=1)=0.40
\ne P(X=1)P(Y=1)=0.42.
$$

### 1.3 Continuous Random Variables

Suppose first that

$$
f_U(u)=
\begin{cases}
2u,&0\le u\le1,\\
0,&\text{otherwise}.
\end{cases}
$$

#### (a) Verify that $f_U$ is a valid PDF.

A PDF must be nonnegative and integrate to one. The proposed function is nonnegative, and

$$
\int_{-\infty}^{\infty}f_U(u)\,du
=\int_0^1 2u\,du
=\left[u^2\right]_0^1
=1.
$$

Thus, $f_U$ is a valid PDF.

#### (b) Derive the CDF $F_U$.

By definition, $F_U(u)=P(U\le u)$. Hence

$$
F_U(u)=
\begin{cases}
0,&u<0,\\
\displaystyle\int_0^u2t\,dt=u^2,&0\le u\le1,\\
1,&u>1.
\end{cases}
$$

#### (c) Compute $P(1/4<U\le3/4)$ using the PDF and the CDF.

Using the PDF,

$$
P(1/4<U\le3/4)
=\int_{1/4}^{3/4}2u\,du
=\left[u^2\right]_{1/4}^{3/4}
=\frac{9}{16}-\frac{1}{16}
=\frac12.
$$

Using the CDF gives the same result:

$$
F_U(3/4)-F_U(1/4)
=\left(\frac34\right)^2-\left(\frac14\right)^2
=\frac12.
$$

#### (d) What is $P(U=1/2)$?

Because $U$ is continuous,

$$
P(U=1/2)=\int_{1/2}^{1/2}f_U(u)\,du=0.
$$

The value $f_U(1/2)=1$ is a density height, not a probability.

#### (e) Find the median $m$.

Since the median lies in $[0,1]$, solve

$$
F_U(m)=m^2=\frac12.
$$

The admissible solution is

$$
m=\frac{1}{\sqrt2}.
$$

#### (f) Compute $E[U]$, $E[U^2]$, and $\operatorname{Var}(U)$.

The first two raw moments are

$$
E[U]
=\int_0^1u(2u)\,du
=2\int_0^1u^2\,du
=\frac23
$$

and

$$
E[U^2]
=\int_0^1u^2(2u)\,du
=2\int_0^1u^3\,du
=\frac12.
$$

Therefore,

$$
\operatorname{Var}(U)
=E[U^2]-E[U]^2
=\frac12-\left(\frac23\right)^2
=\frac1{18}.
$$

Now suppose that

$$
F_V(v)=
\begin{cases}
0,&v<0,\\
1-e^{-v},&v\ge0.
\end{cases}
$$

#### (g) Derive the PDF $f_V$.

Differentiate the CDF at points where it is differentiable:

$$
f_V(v)=
\begin{cases}
e^{-v},&v\ge0,\\
0,&v<0.
\end{cases}
$$

The value assigned to the density at the single point $v=0$ does not affect any probability.

#### (h) Compute $P(V>2)$.

Using the complement rule,

$$
P(V>2)=1-F_V(2)=e^{-2}.
$$

#### (i) Find the 90th percentile of $V$.

Let $q_{0.9}$ satisfy $F_V(q_{0.9})=0.9$. Then

$$
1-e^{-q_{0.9}}=0.9,
$$

so

$$
q_{0.9}=-\log(0.1)=\log 10.
$$

#### (j) Compute $E[V]$, $E[V^2]$, and $\operatorname{Var}(V)$.

Using integration by parts,

$$
E[V]=\int_0^\infty ve^{-v}\,dv=1
$$

and

$$
E[V^2]=\int_0^\infty v^2e^{-v}\,dv=2.
$$

Consequently,

$$
\operatorname{Var}(V)
=E[V^2]-E[V]^2
=2-1^2
=1.
$$

## 2. Linear Algebra and Matrix Algebra

Let

$$
A=
\begin{pmatrix}
1&0\\
1&1\\
1&2
\end{pmatrix}.
$$

### 2.1 Dimensions

#### What are the dimensions of $A$ and $A^\prime$?

Here $A^\prime$ denotes the transpose of $A$. The matrix $A$ has three rows and two columns, so $A\in\mathbb R^{3\times2}$. Therefore, $A^\prime\in\mathbb R^{2\times3}$.

### 2.2 Rank

#### What is the rank of $A$?

The two columns are linearly independent: the second column is not a scalar multiple of the first. Therefore,

$$
\operatorname{rank}(A)=2.
$$

### 2.3 Cross-Product Matrix

#### Compute $A^\prime A$.

$$
A^\prime A
=
\begin{pmatrix}
1&1&1\\
0&1&2
\end{pmatrix}
\begin{pmatrix}
1&0\\
1&1\\
1&2
\end{pmatrix}
=
\begin{pmatrix}
3&3\\
3&5
\end{pmatrix}.
$$

### 2.4 Inverse

#### Is $A^\prime A$ invertible? If so, compute its inverse.

Its determinant is

$$
\det(A^\prime A)=3(5)-3(3)=6\ne0,
$$

so it is invertible. Using the formula for a $2\times2$ inverse,

$$
(A^\prime A)^{-1}
=\frac16
\begin{pmatrix}
5&-3\\
-3&3
\end{pmatrix}.
$$

### 2.5 Full Column Rank

#### What property of $A$ guarantees that $A^\prime A$ is invertible?

$A^\prime A$ is invertible exactly when $A$ has full column rank. To see this, observe that for any $b\in\mathbb R^2$,

$$
b^\prime A^\prime A b=(Ab)^\prime(Ab)=\lVert Ab\rVert^2.
$$

If $A$ has full column rank, then $Ab=0$ implies $b=0$. Thus, $b^\prime A^\prime A b>0$ for every $b\ne0$, making $A^\prime A$ positive definite and therefore invertible.

## 3. Calculus: Taylor Expansions

Let $g(x)=\log(x)$ for $x>0$.

### 3.1 Derivatives

#### Compute $g'(x)$, $g''(x)$, and $g'''(x)$.

$$
g'(x)=\frac1x,
\qquad
g''(x)=-\frac1{x^2},
\qquad
g'''(x)=\frac2{x^3}.
$$

### 3.2 Little-o and Big-O Notation

#### For a fixed positive integer $k$, what do $o(h^k)$ and $O(h^k)$ mean as $h\to0$, precisely and intuitively?

For a remainder function $r$, the statement

$$
r(h)=o(h^k)
$$

means

$$
\lim_{h\to0}\frac{|r(h)|}{|h|^k}=0.
$$

Thus, $r(h)$ becomes negligible relative to $h^k$.

The statement

$$
r(h)=O(h^k)
$$

means that there exist constants $C<\infty$ and $\delta>0$ such that

$$
|r(h)|\le C|h|^k
\qquad
\text{whenever }0<|h|<\delta.
$$

Thus, $r(h)$ is bounded in magnitude by a constant multiple of $|h|^k$ near zero. Little-$o$ is a negligibility statement, whereas big-$O$ is a bounded-order statement. In particular, if $r(h)=O(h^{k+1})$, then $r(h)=o(h^k)$ as $h\to0$.

### 3.3 Taylor Expansions

#### Write the first- and second-order expansions of $g(1+h)$, using both little-o and sharp big-O remainders.

Because

$$
g(1)=0,
\qquad
g'(1)=1,
\qquad
g''(1)=-1,
$$

the first-order Peano expansion is

$$
\log(1+h)=h+o(h).
$$

Because $g''$ is bounded in a neighborhood of $1$, Taylor's theorem gives the sharper remainder statement

$$
\log(1+h)=h+O(h^2).
$$

This big-$O$ order is sharp because

$$
\lim_{h\to0}\frac{\log(1+h)-h}{h^2}=-\frac12;
$$

the remainder is not $o(h^2)$.

The second-order Peano expansion is

$$
\log(1+h)=h-\frac12h^2+o(h^2).
$$

Because $g'''$ is bounded in a neighborhood of $1$, the sharper big-$O$ version is

$$
\log(1+h)=h-\frac12h^2+O(h^3).
$$

This order is also sharp because

$$
\lim_{h\to0}
\frac{\log(1+h)-h+\frac12h^2}{h^3}
=\frac13;
$$

the remainder is not $o(h^3)$.

For example, the Lagrange remainders have the forms

$$
R_1(h)=\frac{g''(1+\vartheta_1h)}{2}h^2,
\qquad
R_2(h)=\frac{g'''(1+\vartheta_2h)}{6}h^3
$$

for some $\vartheta_1,\vartheta_2\in(0,1)$. Boundedness of the relevant derivatives near $1$ establishes the stated big-$O$ orders. Those orders in turn imply $R_1(h)=o(h)$ and $R_2(h)=o(h^2)$.

### 3.4 Numerical Approximation

#### Use both expansions to approximate $\log(1.1)$.

Here $x-1=0.1$. The first-order approximation is

$$
\log(1.1)\approx0.1.
$$

The second-order approximation is

$$
\log(1.1)\approx0.1-\frac12(0.1)^2=0.095.
$$

### 3.5 Accuracy

#### Which approximation is more accurate? Relate the errors to the remainder orders.

The true value is approximately

$$
\log(1.1)\approx0.0953102.
$$

The signed errors are

$$
\log(1.1)-0.1\approx-0.0046898
$$

and

$$
\log(1.1)-0.095\approx0.0003102.
$$

Thus, the second-order approximation is more accurate. With $h=0.1$, the first-order remainder is $O(h^2)$, whereas the second-order remainder is $O(h^3)$. The additional power of $h$ makes the second-order error shrink faster as $h\to0$, although big-$O$ notation by itself does not specify the constants multiplying those powers.

## 4. Calculus: Optimization

Let

$$
q(x,y)=4x+2y-x^2-xy-y^2.
$$

### 4.1 Optimality Conditions

#### (a) State the first-order necessary condition for an interior local maximum of a differentiable function.

Let $f:\mathbb R^k\to\mathbb R$ be differentiable, and let $z^*$ be an interior local maximizer. The first-order necessary condition is

$$
\nabla f(z^*)=0.
$$

This condition requires an interior solution. At a boundary or under constraints, a maximizer need not have a zero gradient.

#### (b) State the second-order sufficient condition for an interior point to be a local maximum of a twice-differentiable function.

Let $f$ be twice differentiable at an interior point $z^*$. A second-order sufficient condition is

$$
\nabla f(z^*)=0
\qquad\text{and}\qquad
\nabla^2 f(z^*)\text{ is negative definite}.
$$

These conditions imply that $z^*$ is a strict local maximizer. Negative semidefiniteness alone is not sufficient in general.

### 4.2 First-Order Conditions

#### Compute the gradient of $q$ and solve the first-order conditions.

The gradient is

$$
\nabla q(x,y)
=
\begin{pmatrix}
4-2x-y\\
2-x-2y
\end{pmatrix}.
$$

The first-order conditions are therefore

$$
2x+y=4,
\qquad
x+2y=2.
$$

Solving this system gives

$$
x^*=2,
\qquad
y^*=0.
$$

Thus, the unique stationary point is $(2,0)$.

### 4.3 Hessian

#### Compute and classify the Hessian.

The Hessian is constant:

$$
\nabla^2q(x,y)
=
\begin{pmatrix}
-2&-1\\
-1&-2
\end{pmatrix}.
$$

Its eigenvalues are $-3$ and $-1$, both strictly negative. Therefore, the Hessian is negative definite. Equivalently, its first leading principal minor is negative and its determinant is positive:

$$
-2<0,
\qquad
\det(\nabla^2q)=4-1=3>0.
$$

### 4.4 Classification and Global Optimality

#### Classify the stationary point. Is it the unique global maximizer?

Because $\nabla q(2,0)=0$ and the Hessian is negative definite, the second-order sufficient condition establishes that $(2,0)$ is a strict local maximizer.

Moreover, the Hessian is negative definite everywhere, so $q$ is strictly concave on the convex domain $\mathbb R^2$. Consequently, every stationary point is the unique global maximizer. Hence

$$
\operatorname*{arg\,max}_{(x,y)\in\mathbb R^2}q(x,y)=(2,0),
$$

and the maximum value is

$$
q(2,0)=4.
$$
