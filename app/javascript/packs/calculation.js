function calculation (){
  const price  = document.getElementById("item-price");
  price.addEventListener("keyup", () => {
    const val = price.value
    const add = val / 10
    const profit_price = val - add
    const Taxval  = document.getElementById("add-tax-price");
    Taxval.innerHTML = `${Math.floor(add)}`;
    const profit_calculation  = document.getElementById("profit");
    profit_calculation.innerHTML = `${Math.floor(profit_price)}`
  });
}
window.addEventListener('load', calculation);