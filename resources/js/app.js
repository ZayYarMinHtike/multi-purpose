/**
* First we will load all of this project's JavaScript dependencies which
* includes Vue and other libraries. It is a great starting point when
* building robust, powerful web applications using Vue and Laravel.
*/

require('./bootstrap');

window.Vue = require('vue');
Vue.use(VueRouter)



import Vue from 'vue'
import VueRouter from 'vue-router'
import Dashboard from './components/Dashboard.vue'
import Profile from './components/Profile.vue'
import Users from './components/Users.vue'
import Blog from './components/Blog.vue'
import Comments from './components/Comments.vue'



let routes = [

    { path: '/dashboard',
     component: Dashboard 
    },

    { path: '/profile',
     component: Profile 
    },

    { path: '/users',
     component: Users 
    },
    
    { path: '/blog',
      component: Blog,
    },
]

const router = new VueRouter({
    mode: 'history',
    routes
})


//using vueform
import { Form, HasError, AlertError } from 'vform'
window.Form = Form;
Vue.component(HasError.name, HasError)
Vue.component(AlertError.name, AlertError)

//using sweet-alerts2
import Swal from 'sweetalert2'
window.Swal = Swal;

const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
})
window.Toast = Toast;




//using vue filters
Vue.filter('upText', function (text) {
    return text.charAt(0).toUpperCase() + text.slice(1)
})

//using moment.js for date-time
import Moment from 'moment'
Vue.filter('myDate', function (date) {
    return Moment(date).format("MMM Do YYYY")
})

//using vue progress-bar
import VueProgressBar from 'vue-progressbar'

Vue.use(VueProgressBar, {
  color: 'rgb(143, 255, 199)',
  failedColor: 'red',
  height: '3px'
})

//why created this? I might use "component-communication" later in my app
window.Fire = new Vue();

//vee validate
import VeeValidate from 'vee-validate';

Vue.use(VeeValidate);

/**
* The following block of code may be used to automatically register your
* Vue components. It will recursively scan this directory for the Vue
* components and automatically register them with their "basename".
*
* Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
*/

// const files = require.context('./', true, /\.vue$/i);
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default));

Vue.component('example-component', require('./components/ExampleComponent.vue').default);

//vue api component
Vue.component(
    'passport-clients',
    require('./components/passport/Clients.vue').default
);

Vue.component(
    'passport-authorized-clients',
    require('./components/passport/AuthorizedClients.vue').default
);

Vue.component(
    'passport-personal-access-tokens',
    require('./components/passport/PersonalAccessTokens.vue').default
);
/**
* Next, we will create a fresh Vue application instance and attach it to
* the page. Then, you may begin adding components to this application
* or customize the JavaScript scaffolding to fit your unique needs.
*/

const app = new Vue({
    router,
    components: { Comments },
}).$mount('#app');
