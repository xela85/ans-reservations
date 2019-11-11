import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import {registerCustomElement, registerPorts} from "elm-mapbox";
// This brings in mapbox required CSS
import "mapbox-gl/dist/mapbox-gl.css";
import "@webcomponents/custom-elements";

registerCustomElement({token: "pk.eyJ1IjoieGVsYTg1IiwiYSI6ImNrMnU5OWV2MzB6aXUzbnA1ZXMxanVxMDkifQ.4zRBHy8rLnvuEL-lJ4ivcg"});

const app = Elm.Main.init({
  node: document.getElementById('root')
});

// registerPorts(app);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
