
$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = ` <div class="category__child" id="children_wrapper">
                        <select id="child__category"  name="item[category_id]" class="select-box2">
                        <option value="">---</option>

                        
                        ${insertHTML}
                        </select>
                      </div>`;
    $('#category_field').append(childSelectHtml);
  }

  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = "";
    grandchildSelectHtml = ` <div class="category__child" id="grandchildren_wrapper">
                              <select id="grandchild__category" name="item[category_id]" class="select-box3">
                                <option value="">---</option>
                                ${insertHTML}
                                </select>
                            </div>`;
    $('#category_field').append(grandchildSelectHtml);
  }



    $('#edit-parent-form').on('change',function(){
      var parentId = document.getElementById('edit-parent-form').value;

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
        $('#category_field_cyu').css('display', 'none');
        var insertHTML = 'parentId';
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


  $('#category_field').on('change','#edit-child__category',function(){
      var childId = document.getElementById('edit-child__category').value;
    if(childId != ""){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        $('#category_field_ge').css('display', 'none');

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