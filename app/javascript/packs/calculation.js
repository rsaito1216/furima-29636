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



     
      
// // 子のselectタグを追加
// function build_childSelect() {
//   let child_select = `
//             <select name="item[category_id]" class="child_category_id">
//               <option value="">---</option>
//             </select>
//             `
//   return child_select;
// }

// // selectタグにoptionタグを追加
// function build_Option(children) {
//   let option_html = `
//                     <option value=${children.id}>${children.name}</option>
//                     `
//   return option_html;
// }




// $(document).on("change", ".child_category_id", function () {
//   // 選択した子の値を取得する
//   let childValue = $(".child_category_id").val();
//   // 初期値("---")以外を選択したらajaxを開始
//   if (childValue.length != 0) {
//     $.ajax({
//       url: '/items/catch',
//       type: 'GET',
//       // itemsコントローラーにparamsをchildren_idで送る
//       data: { children_id: childValue },
//       dataType: 'json'
//     })
//       .done(function (gc_data) {
//         // selectタグを生成してビューにappendする
//         let gc_select = build_gcSelect
//         $("#category_field").append(gc_select);
//         // jbuilderから取得したデータを1件ずつoptionタグにappendする
//         gc_data.forEach(function (gc_d) {
//           let option_html = build_Option(gc_d);
//           $(".gc_category_id").append(option_html);
//         });
//       })
//       .fail(function () {
//         alert("gcで通信エラーです！");
//       });
//   }
// });


// // 孫のselectタグを追加
// function build_gcSelect() {
// let gc_select = `
//       <select name="item[category_id]" class="gc_category_id">
//       </select>
//       `
// return gc_select;
// }


// // function build_gcOption(grandchildren) {
// //   let gcoption_html = `
// //                     <option value=${grandchildren.id}>${grandchildren.name}</option>
// //                     `
// //   return gcoption_html;
// // }
