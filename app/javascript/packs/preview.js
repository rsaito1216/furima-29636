// window.addEventListener("DOMContentLoaded", () => {
//   const path =location.pathname
//   const pathRegex = /^(?=.*items)(?=.*edit)/
//   if (path === "/items/new" || path === "/items" || pathRegex.test(path)) {
  
//   }
// });


// if (document.URL.match("/new") || document.URL.match("items")|| document.URL.match("/edit")) {

  document.addEventListener('DOMContentLoaded', function(){
//     const ImageList = document.getElementById('image-list');
//     const createImageHTML = (blob) => {
//       const imageElement = document.createElement('div')

//       imageElement.setAttribute('class', "image-element")
//       let imageElementNum = document.querySelectorAll('.image-element').length
//       // 表示する画像を生成
//       const blobImage = document.createElement('img');
      
//       blobImage.setAttribute('src', blob );
//       blobImage.style.width = "240px";
//       blobImage.style.height = "135px";

//       const inputHTML = document.createElement('input')
//       inputHTML.setAttribute('id', `item_image_${imageElementNum}`)
//       inputHTML.setAttribute('name', 'item[images][]')
//       inputHTML.setAttribute('type', 'file')
      
      
//       // 生成したHTMLの要素をブラウザに表示させる
//       imageElement.appendChild(blobImage)
//       imageElement.appendChild(inputHTML)
//       ImageList.appendChild(imageElement)

//       inputHTML.addEventListener('change', (e) => {
//           file = e.target.files[0];
//         blob = window.URL.createObjectURL(file);
//         createImageHTML(blob)
               
//                 type = file.type,
//                 errors = ''
         
//             //拡張子は .jpg .gif .png . pdf のみ許可
//             if (type != 'image/jpeg' && type != 'image/gif' && type != 'image/png' && type != 'image/jpg') {
//               errors += '.jpg .gif .png .pdfのいずれかのファイルのみ許可されています\n'
//             }
         
//             if (errors) {
//               //errorsが存在する場合は内容をalert
//               alert(errors)
//               //valueを空にしてリセットする
//               event.currentTarget.value = ''
//             }
      
//       });
//     }
      
    // document.getElementById('item_image').addEventListener('change', function(e){
      // let file = e.target.files[0];
      // let blob = window.URL.createObjectURL(file);

      // createImageHTML(blob)

    // });
  // });
// }




   
$('#item_image').on('change',function(e){
  var files = e.target.files;
  var d = (new $.Deferred()).resolve();
  $.each(files,function(i,file){
    d = d.then(function() {
        return Uploader.upload(file)})
      .then(function(data){
        return previewImage(file, data.image_id);
    });
  });
  $('#item_image').val('');
});


var previewImage = function(imageFile, image_id){
  var reader = new FileReader();
  var img = new Image();
  img.style.width = "150px";
  img.style.height = "110px";
  var def =$.Deferred();
  reader.onload = function(e){
    var image_box = $('<div>',{class: 'image-box'});
    image_box.append(img);
    // image_box.append($('<p>').html(imageFile.name));
    image_box.append($('<input>').attr({
          name: "item[images][]",
          value: image_id,
          style: "display: none;",
          type: "hidden",
          class: "item-images-input"}));
    image_box.append('<a href="" class= "btn-edit">入れ替え　</a>');
    image_box.append($('<input>').attr({
          name: "edit-image[]",
          style: "display: none;",
          type: "file",
          class: "edit-image-file-input file-input"}));
    image_box.append('<a href="" class="btn-delete">削除</a>');
    $('#image-list').append(image_box);
    img.src = e.target.result;
    def.resolve();
  };
  reader.readAsDataURL(imageFile);
  return def.promise();
}

var Uploader = {
  upload: function(imageFile){
    var def =$.Deferred();
    var formData = new FormData();
    formData.append('image', imageFile);
    $.ajax({
      type: "POST",
      url: '/items/upload_image',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
      success: def.resolve
    })
    return def.promise();
  }
}

$('#image-list').on('click','.btn-edit', function(e){
  e.preventDefault();
  $(this).parent().find('.edit-image-file-input').trigger("click");
});

$('#image-list').on('change','.edit-image-file-input', function(e){
  var file = e.target.files[0];
  var image_box = $(this).parent();
  Uploader.upload(file).done(function(data){
    replaceImage(file, data.image_id, image_box);
  });
});

$('#image-list').on('click','.btn-delete', function(e){
  e.preventDefault();
  $(this).parent().remove();
});

var replaceImage = function(imageFile, image_id, element){
  var reader = new FileReader();
  var img = element.find('img');
  var input = element.find('.item-images-input');
  var filename = element.find('p');
  reader.onload = function(e){
    input.attr({value: image_id});
    filename.html(imageFile.name);
    img.attr("src", e.target.result);
  };
  reader.readAsDataURL(imageFile);
}
  });