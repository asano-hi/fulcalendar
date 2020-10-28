<template>
  <div class="container">
    <Header />
    <Calendar
    :events="events"
    @eventClick="removeEvent"
    @eventChange="changeEvent"
    />
    <div class="form-box row">
      <div class="form col-3">
        <label>title</label>
        <input v-model="eventForm.title" type="text" />
      </div>
      <div class="form col-3">
        <label>start-time</label>
        <input v-model="eventForm.start" type="datetime-local" />
      </div>
      <div class="form col-3">
        <label>end-time</label>
        <input v-model="eventForm.end" type="datetime-local" />
      </div>
    </div>
    <Button @click="addEvent">イベントを追加</Button>
  </div>
</template>

<script>
import Calendar from './components/Calendar';
import Header from './components/Header';
import axios from 'axios';

export default {
  components: {
    Calendar,
    Header
  },
  data() {
    return {
      events: '/events.json',
      eventForm: {
        title: "新しいイベント",
        start: "yyyy-MM-dd"
      }
    }
  },
  mounted() {
    axios
      .get('/api/v1/events.json')
      .then(response => (this.events = response.data))
  },
  methods: {
    addEvent: function() {
      this.events.push({
        id: String(this.events.length + 1),
        ...this.eventForm
      })
    },
    removeEvent: function(eventInfo) {
      this.events = this.events.filter(event => {
        return event.id != eventInfo.event.id
      })
    },
    changeEvent: function(eventInfo) {
      this.events = this.events.map(event => {
        if(event.id === eventInfo.event.id) {
          event = eventInfo.event.toJSON()
        }
        return event;
      })
    }
  },
}
</script>

<style scoped>
  .form-box{
    display: flex;
    text-align: center;
    box-shadow: 1px 3px 5px rgba(0,0,0,0.25);
  }

  .form{
    margin-left: 8%;
  }

  input{
    width: 90%;
  }

button{
  margin-left: 40%;
}

</style>