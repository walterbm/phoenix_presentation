import 'zepto'
import Turbolinks from 'turbolinks';
import Rx from 'rx'

function getSlide(location) {
  const regx = /presentation\/(\d+)/i
  const param = location.match(regx)
  if (param && param[1]) {
    return parseInt(param[1])
  }
  return 0
}

function getSlides(location) {
  const current = getSlide(location)
  return {
    next: current + 1,
    previous: current - 1 >= 0 ? current -1 : 0
  }
}

function navigateToSlide(keyCode) {
  const slides = getSlides(window.location.pathname)

  switch (keyCode) {
    case 37:
      Turbolinks.visit(`/presentation/${slides.previous}`)
      break;
    case 39:
      Turbolinks.visit(`/presentation/${slides.next}`)
      break;
    default:
      break;
  }
}

function start() {
  const doc = $(document)

  const keyStream = Rx.Observable.fromEvent(doc, 'keyup')
    .pluck('keyCode')
    .filter(code => code === 37 || code === 39 )
    .debounce(150)
    .take(1)

  keyStream.subscribe(navigateToSlide);
}

export default {
  start
};
