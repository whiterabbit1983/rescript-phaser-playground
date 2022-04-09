open Phaser

module Level = Scene.Make({
  open Scene

  type t = Scene.t

  let preload =
    @this
    s => {
      s->Load.setBaseURL("https://labs.phaser.io")
      s->Load.image("sky", "assets/skies/space3.png")
      s->Load.image("logo", "assets/sprites/phaser3-logo.png")
      s->Load.image("red", "assets/particles/red.png")
    }

  let create =
    @this
    s => {
      s->Add.image(400, 300, "sky")
      let particles = s->Add.particles("red")
      let emitter = particles->createEmitter({
        "speed": 100,
        "scale": {
          "start": 1,
          "end": 0
        },
        "blendMode": "ADD",
      })
      let logo = s->Physics.Add.image(450, 100, "logo")
      logo->setVelocity(100, 200)
      logo->setBounce(1, 1)
      logo->setCollideWorldBounds(true)

      emitter->startFollow(logo)
    }
})

let config = {
    "type": "AUTO",
    "width": 800,
    "height": 600,
    "physics": {
        "default": "arcade",
        "arcade": {
            "gravity": { "y": 200 }
        }
    },
    "scene": [Level.make()]
  };
  Game.make(config)->ignore