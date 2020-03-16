require('jquery')
import "bootstrap";
import flatpickr from "flatpickr";
import {progressBar} from "../plugins/progress_bar"
import { pickDates } from "../plugins/init_flatpickr";
import {initCamera} from "../plugins/init_camera";


initCamera();
pickDates();
progressBar();