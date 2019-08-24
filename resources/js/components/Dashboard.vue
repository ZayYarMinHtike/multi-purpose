<template>
    <div class="container">
        <div v-if="!$gate.isAdmin()">
          <Not-found></Not-found>
        </div>
        <div class="row justify-content-center" v-if="$gate.isAdmin()">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Dashboard Component</div>

                    <div class="card-body">
                        I'm an example component.
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
