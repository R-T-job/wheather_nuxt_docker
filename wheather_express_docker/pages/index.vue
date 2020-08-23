<template>
  <div class="container">
    <Location v-bind="location"/>
    <div class="temperature" @click="changeDegree()">
      <div class="degree-section">
        <h2 class="temprature-degree">{{ tempratureDegree }}</h2>
        <span>{{ degreeSpan }}</span>
      </div>
      <div class="temprature-description">{{ tempratureDescription }}</div>
    </div>
  </div>
</template>

<script>
import Location from '~/components/Location.vue'

import axios from 'axios'
export default {
  components: {
    Location
  },
  data () {
    return {
      tempCentigrade: null, //摂氏保存用
      tempratureDescription: null,
      tempratureDegree: null,

      degreeSection: null,
      degreeSpan: "C",
      location: {
        locationTimezone: null,
        wheatherIconSrc: null
      }
    }
  },
  mounted () {
    if (process.browser) {
      if ( navigator.geolocation ) {
        navigator.geolocation.getCurrentPosition(position => {
          let lon = position.coords.longitude;
          let lat = position.coords.latitude;
          const appid = process.env.APP_ID;
          const units = "metric"
          const apiURL = process.env.APP_URL

          axios.get(apiURL, {
            params: {
              lat: lat,
              lon: lon,
              units: units,
              appid: appid,
            }
          }).then(response => {
            console.log(response)
            this.tempCentigrade = response.data.main.temp

            const description = response.data.weather[0].description;

            this.tempratureDegree = this.tempCentigrade;
            this.tempratureDescription = description;

            //　国、地域名取得
            const country = response.data.sys.country
            const name = response.data.name
            // 地域ごとの時間および天気
            this.location.locationTimezone = `${country}/${name}`;

            const icon = response.data.weather[0].icon;
            this.location.wheatherIconSrc = `http://openweathermap.org/img/wn/${icon}@2x.png`;
          })
          .catch(response => console.log(response))
        });
      }
    } else {
      this.location.locationTimezone = "hey dis is not working because resons"
    }
  },
  methods: {
    changeDegree(){
      if(this.degreeSpan === "C"){
        this.degreeSpan = "F";
        let farenheit = (this.tempCentigrade) * (9 / 5) + 32
        this.tempratureDegree = Math.floor(farenheit);
      } else {
        this.degreeSpan = "C";
        this.tempratureDegree = this.tempCentigrade;
      }
    }
  }
}
</script>

<style>
.container {
    height: 100vh;
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items:center;
    background: linear-gradient(rgb(47,150,163), rgb(48,62,143));
    font-family: sans-serif;
    color: white;
}
.temperature {
    height: 30vh;
    width: 50%;
    display: flex;
    justify-content: space-around;
    align-items: center;
}
.temperature {
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
