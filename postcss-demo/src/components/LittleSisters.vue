<template lang="pug">
    .container
        h1 littleSister
        ul
            li(v-for="(item,index) of wallpapers" :key="index")
                img(:src='getImg(item)',:alt='item')
                p  {{item}}

</template>
<script>
    export default {
        name:'LittleSisters',
        data() {
            return {
                wallpapers: ["w1", 'w2', 'w3', 'w4', 'w5', 'w6']
            }
        },
        methods:{
            getImg(name) {
                name = name.toLowerCase().replace(/\s/g, '_');
                return `/img/${name}.jpg`
            }
        }
    }
</script>
<style lang="postcss" scoped>
    @import "../assets/css/variable.css";

    body {
        color: var(--black);
        font-family: system-ui;
        max-width: 1200px;
        margin: 0 auto;
        padding: var(--space);

    }

    h1 {
        text-align: center;
        margin-bottom: var(--space);
    }

    ul {
        list-style-type: none;
        margin: 0 auto;
        padding-left: 0;
        display: grid;
        grid-gap: var(--space);
    }

    li {
        margin: 0 auto;
        text-align: center;
        grid-template-columns: 1fr 1fr;
    }


    img {
        max-width: 100%;
        filter: grayscale(1);
    }

    img:hover {
        filter: grayscale(0);
    }

</style>