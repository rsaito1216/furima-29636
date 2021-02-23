$(function(){
  // 検索フォームでのカテゴリーの挙動
  function appendOption(category){
   let html = `<option value="${category.id}" >${category.name}</option>`;
   return html;
 }
 function appendCheckbox(category){
   let html =`
               <li class="sc-side__detail__field__form--checkbox" id="glandchildcategory-area">
               
                 <div class="sc-side__detail__field__form--checkbox__btn js_search_checkbox" >
                   <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}" >
                 </div>

                 <div class="sc-side__detail__field__form--checkbox__label">
                   <label for="q_category_id_in_${category.id}">${category.name}</label>
                 </div>
               
               </li>
               
               `
   return html;
 }

 // 子カテゴリーの表示作成
 function appendChildrenBox(insertHTML){
   const childSelectHtml = `<li>
                             <select id="children_category_search" name="q[category_child_id_eq]" class="search-select-box-2">
                               <option value="">選択してください</option>
                               ${insertHTML}
                             </select>
                           </li>`;
   $('.field__input--category_search').append(childSelectHtml);
 }

 // 孫カテゴリーの表示作成
 function appendGrandchildrenBox(insertHTML){
   const grandchildSelectHtml =`

   <ul id="grandchildren_category_checkboxes" class="checkbox-list">

   <div class="sc-side__detail__field">
     <div class="sc-side__detail__field__form--checkbox__btn js_search_checkbox">
       <input class="js-checkbox-all" id="grandchildren_category_all" type="checkbox">
     </div>
     <lable>
     <div class="">
     <label for="grandchildren_category_all" class="">すべて選択・解除</label>
     </div>
     </lable>
   </div>
   
                         ${insertHTML}
                         
                         </ul>
                      `;

   $('.field__input--category_search').append(grandchildSelectHtml);
 }

 // ①「すべて」をクリックした時の挙動
 $(document).on('change', '#grandchildren_category_all', function() {
   $('input[type=checkbox]', '#grandchildren_category_checkboxes').prop('checked', this.checked);
 });
   
 // 孫カテゴリーの表示作成

 $('#q_category_parent_id_eq').on('change', function(){
   var parentId = document.getElementById('q_category_parent_id_eq').value;
   if (parentId != ""){
     $.ajax({
       url: '/items/get_category_children/',
       type: 'GET',
       data: { parent_id: parentId },
       dataType: 'json'
     })
   .done(function(children){
     //親が変更された時、子以下を削除する
    $('#children_category_search').remove();
    $('#grandchildren_category_checkboxes').remove();
    let insertHTML = '';
    children.forEach(function(child){
      insertHTML += appendOption(child);
    });
    appendChildrenBox(insertHTML);
  })
  .fail(function(){
    alert('カテゴリー取得に失敗しました');
  })
 }else{
   //親カテゴリーが初期値になった時、子以下を削除する
   $('#children_category_search').remove();
   $('#grandchildren_category_checkboxes').remove();
 }
});
// 子カテゴリー選択後のイベント
$('.field__input--category_search').on('change', '#children_category_search', function(){
 const childId = $(this).val();
 //選択された子カテゴリーのidを取得
 if (childId != ""){ 
   //子カテゴリーが初期値でないことを確認
   $.ajax({
     url: '/items/get_category_grandchildren',
     type: 'GET',
     data: { child_id:  childId},
     dataType: 'json'
   })
   .done(function(grandchildren){
     if (grandchildren.length != 0) {
       //子が変更された時、孫以下を削除する
       $('#grandchildren_category_checkboxes').remove();
       let insertHTML = '';
       grandchildren.forEach(function(grandchild){
         insertHTML += appendCheckbox(grandchild);
       });
       appendGrandchildrenBox(insertHTML);
     }
   })
   .fail(function(){
     alert('カテゴリー取得に失敗しました');
   })
 }else{
   $('#grandchildren_category_checkboxes').remove();
 }
});
});


$('#detail_search_btn').click(function(e) {
 if ($('#children_category_search').val() == "") {
   $('#children_category_search').remove();
 }
});


$(document).on('change', '#all-condition', function() {
 // idがupdateAreaの子要素のcheckboxにのみチェック状態を反映
 $('input[type=checkbox]', '#conditionArea').prop('checked', this.checked);
 });
 
$(document).on('change', '#all-delivery', function() {
 // idがupdateAreaの子要素のcheckboxにのみチェック状態を反映
 $('input[type=checkbox]', '#deliveryArea').prop('checked', this.checked);
 });
 
 //全選択・全解除をクリックしたとき
$(document).on('change', '#all-shipping', function() {
 //チェックしたチェックボックスの状態を他のチェックボックスに反映
 $('input[type=checkbox]', '#shippingArea').prop('checked', this.checked);
 });