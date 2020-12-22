window.addEventListener("DOMContentLoaded", () => {
  const path =location.pathname
  const pathRegex = /^(?=.*items)(?=.*edit)/

  if (path === "/items/new" || path === "/items" || pathRegex.test(path)) {
    function calculation (){
      const price = document.getElementById("item-price");
      price.addEventListener("keyup", () => {
        const val = price.value
        const add = val / 10
        const profit_Price = val - add
  
        const taxVal = document.getElementById("add-tax-price");
        taxVal.innerHTML = Math.floor(add).toLocaleString();
        
        const profit_Calculation = document.getElementById("profit");
        profit_Calculation.innerHTML = Math.ceil(profit_Price).toLocaleString();
      });
    }
    window.addEventListener('load', calculation);
  }
});
