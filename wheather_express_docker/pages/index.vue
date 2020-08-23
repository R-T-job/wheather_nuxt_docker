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
import Logo from '~/components/Logo.vue'
import Location from '~/components/Location.vue'
import axios from 'axios'
export default {
  components: {
    Logo,
    Location
  },
  data () {
    return {
      lon: null,
      lat: null,
      units: null,
      appid: null,

      temp: null,

      tempratureDescription: null,
      tempratureDegree: null,
      locationTimezone: null,
      wheatherIconSrc: null,
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
          console.log(position)
          this.lon = position.coords.longitude;
          this.lat = position.coords.latitude;
          this.appid = process.env.APP_ID;
          this.units = "metric"
          const apiURL = process.env.APP_URL

          axios.get(apiURL, {
            params: {
              lat: this.lat,
              lon: this.lon,
              units: this.units,
              appid: this.appid,
            }
          }).then(response => {
            console.log(response)
            this.temp = response.data.main.temp;
            const description = response.data.weather[0].description;

            this.tempratureDegree = this.temp;
            this.tempratureDescription = description;

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
      locationTimezone = "hey dis is not working because resons"
    }
  },
  methods: {
    changeDegree(){
      console.log(this.degreeSpan)
      if(this.degreeSpan === "C"){
        this.degreeSpan = "F";
        let farenheit = (this.temp) * (9 / 5) + 32
        this.tempratureDegree = Math.floor(farenheit);
      } else {
        this.degreeSpan = "C";
        this.tempratureDegree = this.temp;
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
.location,
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
