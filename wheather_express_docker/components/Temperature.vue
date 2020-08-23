<template>
    <div class="temperature" @click="changeDegree()">
      <div class="degree-section">
        <h2 class="temprature-degree">{{ innerTempratureDegree }}</h2>
        <span>{{ degreeSpan }}</span>
      </div>
      <div class="temprature-description">{{ tempratureDescription }}</div>
    </div>
</template>

<script>
export default {
  props: {
    tempCentigrade: Number,
    tempratureDegree: Number,
    tempratureDescription: String,
  },
  data() {
    return{
      degreeSpan: "C",
      innerTempratureDegree: null
    }
  },
  methods: {
    changeDegree(){
      if(this.degreeSpan === "C"){
        this.degreeSpan = "F";
        let farenheit = (this.tempCentigrade) * (9 / 5) + 32
        this.innerTempratureDegree = Math.floor(farenheit);
      } else {
        this.degreeSpan = "C";
        this.innerTempratureDegree = this.tempCentigrade;
      }
    }
  },
  watch: {
    tempratureDegree: { // プロパティの中身が変更になったら実行される
        immediate: true,
        handler(value) {
            this.innerTempratureDegree = value;
        }
    }
  }
}
</script>

<style>
.temperature {
    height: 30vh;
    width: 50%;
    display: flex;
    justify-content: space-around;
    align-items: center;
    flex-direction: column;
}
.degree-section {
    display: flex;
    align-items: center;
}
.degree-section span {
    margin: 10px;
    font-size: 30px;
}
.degree-section h2 {
    font-size: 40px;
}
</style>
