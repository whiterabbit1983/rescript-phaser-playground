module type SceneType = {
  type t

  let preload: @this (t => unit)
  let create: @this (t => unit)
}

module Scene = {
  type t
  type particlesType
  type image
  type emitter

  @send external setVelocity: (image, int, int) => unit = "setVelocity"
  @send external setBounce: (image, int, int) => unit = "setBounce"
  @send external setCollideWorldBounds: (image, bool) => unit = "setCollideWorldBounds"

  @send external startFollow: (emitter, image) => unit = "startFollow"

  @send external createEmitter: (particlesType, {..}) => emitter = "createEmitter"

  module Make = (S: SceneType) => {
    type t = S.t

    let preload = S.preload
    let create = S.create

    let make = () =>
      {
        "preload": preload,
        "create": create,
      }
  }

  module Load = {
    @send @scope("load") external setBaseURL: (t, string) => unit = "setBaseURL"
    @send @scope("load") external image: (t, string, string) => unit = "image"
  }

  module Add = {
    @send @scope("add") external image: (t, int, int, string) => unit = "image"
    @send @scope("add") external imageF: (t, int, int, string) => image = "image"

    @send @scope("add") external particles: (t, string) => particlesType = "particles"
  }

  module Physics = {
    module Add = {
      @send @scope(("physics", "add")) external image: (t, int, int, string) => image = "image"
    }
  }
}

module Game = {
  type t

  @module("phaser") @new external make: {..} => t = "Game"
}
