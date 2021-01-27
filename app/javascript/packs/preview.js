// window.addEventListener("DOMContentLoaded", () => {
//   const path =location.pathname
//   const pathRegex = /^(?=.*items)(?=.*edit)/
//   if (path === "/items/new" || path === "/items" || pathRegex.test(path)) {
  
//   }
// });


if (document.URL.match("/new") || document.URL.match("items")|| document.URL.match("/edit")) {

  document.addEventListener('DOMContentLoaded', function(){
    const ImageList = document.getElementById('image-list');
    
    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div')

      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length
      // 表示する画像を生成
      const blobImage = document.createElement('img');
      
      blobImage.setAttribute('src', blob );
      blobImage.style.width = "240px";
      blobImage.style.height = "135px";

      const inputHTML = document.createElement('input')
      inputHTML.setAttribute('id', `item_image_${imageElementNum}`)
      inputHTML.setAttribute('name', 'item[images][]')
      inputHTML.setAttribute('type', 'file')
      
      
      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage)
      imageElement.appendChild(inputHTML)
      ImageList.appendChild(imageElement)

      inputHTML.addEventListener('change', (e) => {
          file = e.target.files[0];
        blob = window.URL.createObjectURL(file);
         
        createImageHTML(blob)
      });
    }
      
    document.getElementById('item_image').addEventListener('change', function(e){
      
      let file = e.target.files[0];
      let blob = window.URL.createObjectURL(file);

      createImageHTML(blob)

    });
  });
}