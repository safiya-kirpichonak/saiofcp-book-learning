const factorial = (result, count) => {
  if (count === 0) return 1;
  if (count === 1) return result;
  return factorial(result * count, count - 1);
};

const pascalFormula = (rowNumber, itemNumber) => {
  return (
    factorial(1, rowNumber) /
    (factorial(1, itemNumber) * factorial(1, rowNumber - itemNumber))
  );
};

const pascal = (count) => {
  pascalIteration(0, 0, count);
};

const pascalIteration = (row, item, count) => {
  if (row > count) return;

  console.log(`${row}:${item} = ${pascalFormula(row, item)}`);

  if (item === row) {
    item = 0;
    row++;
  } else {
    item++;
  }

  return pascalIteration(row, item, count);
};

console.log(pascal(3));
