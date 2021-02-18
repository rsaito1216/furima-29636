// function pullDown() {

//   const pullDownButton = document.getElementById("lists")
//   const pullDownParents = document.getElementById("pull-down")
//   const pullDownChild = document.querySelectorAll(".pull-down-list")

//   pullDownButton.addEventListener('mouseover', function(){
//     this.setAttribute("style", "background-color:rgb(195, 153, 207);")
//   })

//   pullDownButton.addEventListener('mouseout', function(){
//     this.removeAttribute("style", "background-color:rgb(195, 153, 207);")
//   })

//   pullDownButton.addEventListener('click', function() {
//     if (pullDownParents.getAttribute("style") == "display:block;") {
//       pullDownParents.removeAttribute("style", "display:block;")
//     } else {
//       pullDownParents.setAttribute("style", "display:block;")
//     }
//   })

//   pullDownChild.forEach(function(list) {
//     list.addEventListener('click', function() {
//       value = list.innerHTML
//       currentList.innerHTML = value
//     })
//   })
// }

// window.addEventListener('load', pullDown)