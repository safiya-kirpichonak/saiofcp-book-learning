function integralSimpson(f, a, b, n) {
  if (n % 2 !== 0) throw new Error("n should be even!");

  const h = (b - a) / n;
  let sum = f(a) + f(b);

  for (let i = 1; i < n; i++) {
    const x = a + i * h;
    sum += (i % 2 === 0 ? 2 : 4) * f(x);
  }

  return (h / 3) * sum;
}
