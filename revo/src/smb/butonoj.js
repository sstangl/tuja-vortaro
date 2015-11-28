
  var imgs = new Array(4);

  function addImg(inx,normal,highlighted)
  {
    norm = new Image();
    norm.src = normal;
    high = new Image();
    high.src = highlighted;

    imgs[inx] = {norm: norm, high: high}
  }  

  addImg(0,"../smb/nav_eo1.png","../smb/nav_eo2.png");
  addImg(1,"../smb/nav_lng1.png","../smb/nav_lng2.png");
  addImg(2,"../smb/nav_fak1.png","../smb/nav_fak2.png");
  addImg(3,"../smb/nav_ktp1.png","../smb/nav_ktp2.png");

  function highlight(inx) {
    window.document.images[inx].src = imgs[inx].high.src;
    window.document.images[inx].className = "btn_hover";
  }

  function normal(inx) {
    window.document.images[inx].src = imgs[inx].norm.src;
    window.document.images[inx].className = "btn";
  }
