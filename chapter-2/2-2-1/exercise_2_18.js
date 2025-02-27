const reverse = (items) => {
  if (items.length === 0) return [];
  const [first, ...other] = items;
  const acc = reverse(other);
  return acc.concat(first);
};

console.log(reverse([1, 2, 3])); // [3, 2, 1]
