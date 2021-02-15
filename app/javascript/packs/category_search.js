
$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class="category__child" id="children_wrapper">
                        <select id="q_category_child_id_eq_any" name="q[category_child_id_eq_any]" class="select-box1">
                          <option value="">---</option>
                          ${insertHTML}
                        </select>
                      </div>`;
    $('#ccategory_field').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="category__child" id="grandchildren_wrapper">
    <select id="q_category_id_eq_any" name="q[category_id_eq_any]" class="select-box1">
      <option value="">---</option>
      ${insertHTML}
      </select>
  </div>`;
    $('#ccategory_field').append(grandchildSelectHtml);
  }

  $('#q_category_parent_id_eq_any').on('change',function(){
    var parentId = document.getElementById('q_category_parent_id_eq_any').value;

    if (parentId != ""){
      $.ajax({
        url: '/items/get_category_children/',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  $('#ccategory_field').on('change','#q_category_child_id_eq_any',function(){
    var childId = document.getElementById('q_category_child_id_eq_any').value;
    if(childId != ""){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  })
});