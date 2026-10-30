# Issues

- Draw by traversing nodes

- Fix the API so `start_drawing`, `draw_model` and `finish_drawing` make sense

- Refactor `assert_manager_upload_model` so it batches or uploads

- Refactor `upload_*` procedures in `Renderer` so there's better batching

- Simplify Renderer's state. It looks like we keep there things that are not need:
    - `textures`
    - `materials`
    - `indices`
    - `vertices`

- Create render target
