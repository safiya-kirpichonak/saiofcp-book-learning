// BAD

const addParens = (expression) => {
  const operands = expression.replace(/[(,)]/g, "").split("+");

  const result = [];
  for (let i = 0; i < operands.length; i++) {
    if (i === 1) continue;
    result.unshift("(");

    if (result.length === 1) {
      result.push(operands[i]);
      result.push("+");
      result.push(operands[i + 1]);
      result.push(")");
    } else {
      result.push("+");
      result.push(operands[i]);
      result.push(")");
    }
  }

  return result.join("");
};

console.log(addParens("(x+3+(x+y+2))")); // ((((x+3)+x)+y)+2)
console.log(addParens("(x+3+(x+y+2)+1)")); // (((((x+3)+x)+y)+2)+1)
