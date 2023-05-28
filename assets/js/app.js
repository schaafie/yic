// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "./vendor/some-package.js"
//
// Alternatively, you can `npm install some-package` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
import YicConf from "./yic-conf"
import YicDatamodel from "./yic-datamodel.js"
import YicAuth from "./yic-auth.js"
import YicController from './yic-controller.js'
// Import webcomponents
import CodejarEditor from './webcomponents/codejar-editor.js'
import YicView from './webcomponents/yic-view.js'
import YicTopMenu from './webcomponents/yic-top-menu.js'
import YicSideMenu from './webcomponents/yic-side-menu.js'
import YicPanel from './webcomponents/yic-panel.js'
import YicOVerview from './webcomponents/yic-overview.js'
import YicForm from './webcomponents/yic-form.js'
import YicTabs from './webcomponents/yic-tabs.js'
import YicGroups from './webcomponents/yic-groups.js'
import YicGrid from './webcomponents/yic-grid.js'
import YicFormAction from './webcomponents/yic-form-action.js'
import YicFormTextareaInput from './webcomponents/yic-form-textarea-input.js'
import YicFormTextInput from './webcomponents/yic-form-text-input.js'
import YicFormJsonInput from './webcomponents/yic-form-json-input.js'
import YicFormNumberInput from './webcomponents/yic-form-number-input.js'
import YicFormPasswordInput from './webcomponents/yic-form-password-input.js'

// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket    