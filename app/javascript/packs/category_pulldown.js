if (document.URL.match(/categories/) || document.URL.match(/""/)) {

window.addEventListener('load', function(){
  const pullDownButton = document.getElementById("category-lists")
  const pullDownParents = document.getElementById("seach-pulldown")
  const pullDownP = document.getElementById("category-search-no-area")

  pullDownButton.addEventListener('mouseover', function() {
    if (pullDownParents.getAttribute("style") == "display:flex;") {
      // pullDownParentsにdisplay:block;が付与されている場合（つまり表示されている時）実行される
      pullDownParents.removeAttribute("style", "display:flex;")
              pullDownButton.setAttribute("style", "color: black;")
    } 
    else {
                // pullDownParentsにdisplay:block;が付与されていない場合（つまり非表示の時）実行される
                pullDownParents.setAttribute("style", "display:flex;")
              }
          pullDownButton.setAttribute("style", "color: #00FF66;")
     })

  pullDownParents.addEventListener('mouseleave', function() {
            // pullDownParentsにdisplay:block;が付与されている場合（つまり表示されている時）実行される
            pullDownParents.removeAttribute("style", "display:flex;")
            pullDownButton.setAttribute("style", "color: black;")
        })

        pullDownP.addEventListener('mouseover', function() { 
          if (pullDownParents.getAttribute("style") == "display:flex;") {
            // pullDownParentsにdisplay:block;が付与されている場合（つまり表示されている時）実行される
            pullDownParents.removeAttribute("style", "display:flex;")
                    pullDownButton.setAttribute("style", "color: black;")
          } 
        })


  $(function() {
    var jqxhr;
  // 子カテゴリーを追加するための処理です。
    function buildChildHTML(child){
      var html =`<li><a class="child_category" id="${child.id}" 
                  href="/categories/${child.id}/child">${child.name}</a></li>`;
      return html;
    }



    $(".search-pull-down").on("mouseover", function() {
      if (jqxhr) {
        jqxhr.abort();
    }
      var id = this.id//どのリンクにマウスが乗ってるのか取得します
      $(".now-selected-red").removeClass("now-selected-red")//赤色のcssのためです
      $('#' + id).addClass("now-selected-red");//赤色のcssのためです
      $(".child_category").remove();//一旦出ている子カテゴリ消します！
      $(".grand_child_category").remove();
      jqxhr = $.ajax({
        url: '/items/get_category_children/',
        type: 'GET',
        data: {parent_id: id},
        dataType: 'json'
      })
      .done(function(children) {
        children.forEach(function (child) {//帰ってきた子カテゴリー（配列）
          var html = buildChildHTML(child);//HTMLにして
          $(".children_list").append(html);//リストに追加します
        })
      });
    });
  
    // 孫カテゴリを追加する処理です　基本的に子要素と同じです！
    function buildGrandChildHTML(child){
      var html =`<ul><a class="grand_child_category" id="${child.id}"
                 href="/categories/${child.id}/grandchild">${child.name}</a></ul>`;
      return html;
    }
  
    $(document).on("mouseover", ".child_category", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
      if (jqxhr) {
        jqxhr.abort();
    }
      var id = this.id
      $(".now-selected-gray").removeClass("now-selected-gray");//灰色のcssのため
      $('#' + id).addClass("now-selected-gray");//灰色のcssのため
      jqxhr = $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: {child_id: id},
        dataType: 'json'
      })
      .done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseover", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });  
    $(document).on("mouseover", ".grand_child_category", function () {
      if (jqxhr) {
        jqxhr.abort();
    }
      var id = this.id
      $(".now-selected-blue").removeClass("now-selected-blue");
      $('#' + id).addClass("now-selected-blue");
    });
  });

});

}