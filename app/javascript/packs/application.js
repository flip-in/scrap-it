import "bootstrap";
import flatpickr from "flatpickr";
import { progressBar } from "../plugins/progress_bar"
import { pickDates } from "../plugins/init_flatpickr";
import { initCamera } from "../plugins/init_camera";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import { initMapbox } from '../plugins/init_mapbox';


initCamera();
pickDates();
progressBar();

initMapbox();


  // const firstRewardBtn = document.querySelector("#pills-rewards-tab");
  // firstRewardBtn.addEventListener("click", (event) => {
  //   const firstBtnRedeem = document.querySelector("#first-btn-redeem");
  //   firstBtnRedeem.addEventListener("click", (event) => {
  //     const redeemBtn = document.querySelector("#otp");
  //     redeemBtn.addEventListener("click", (event)=> {
  //     })
  //   })
  // })
