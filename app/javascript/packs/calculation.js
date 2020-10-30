

if (document.URL.match("/new") || document.URL.match("/edit")) {
  function calculation (){
    const price  = document.getElementById("item-price");
    price.addEventListener("keyup", () => {
      const val = price.value
      const add = val / 10
      const profit_price = val - add
      
      // カンマ表示の実験
      var num = add;
      var after = String(num).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,' );
      console.log(after);
      // カンマ表示の実験

      const Taxval  = document.getElementById("add-tax-price");
      Taxval.innerHTML = Math.floor(add);
      const profit_calculation  = document.getElementById("profit");
      profit_calculation.innerHTML = Math.floor(profit_price);
    });
  }
  window.addEventListener('load', calculation);
}