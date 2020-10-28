document.addEventListener('DOMContentLoaded', function(){
  const ImageList = document.getElementById('image-list');
  
  const createImageHTML = (blob) => {
    // 画像を表示するためのdiv要素を生成
   const imageElement = document.createElement('div');
   imageElement.classList.add( "preview-image" ) ;
   // 表示する画像を生成
   const blobImage = document.createElement('img');
   
   blobImage.setAttribute('src', blob );
   blobImage.style.width = "250px";
   blobImage.style.height = "200px";
   
   // 生成したHTMLの要素をブラウザに表示させる
   imageElement.appendChild(blobImage);
   
   ImageList.appendChild(imageElement);
 };
  
  document.getElementById('item-image').addEventListener('change', function(e){
    const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    createImageHTML(blob);
  });
});