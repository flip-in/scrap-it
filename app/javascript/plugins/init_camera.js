const initCamera = () => {
  const toggle = document.querySelector('#camera-toggle');
  const cameraInput = document.querySelector('#camera-input');
  if (toggle) {
    toggle.addEventListener('click', e =>{
      cameraInput.click()
    }); 
  };

}

export {initCamera}