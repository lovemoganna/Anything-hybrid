import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

// import components
import LittleSisters from '../components/LittleSisters'
import TestDemo from '../components/TestDemo'


const routes = [
    {path: '/littleSisters', component: LittleSisters},
    {path: '/test', component: TestDemo}]

export default new Router({
    routes
})

