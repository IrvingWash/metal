# Issues

- Add picking

- Refactor shader handling so they're on their own. Add metainfo for each one

- Refactor presentation out of `finish_frame`

- Identify duplicated VK code and refactor, so later we can add other backends

- Group instances so instance_count is not hardoced to 1 in Draw_Indexed_Indirect_Command

- Add logs everywhere

- Refactor pbr shader

- Generate tangents

- Sort everything so parent nodes come before children nodes so we don't need to use recursion when traversing the nodes

- Add caching in `asset_manger`

- Refactor `assert_manager_upload_model` so it batches or uploads

- Refactor `upload_*` procedures in `Renderer` so there's better batching

- Calculate radius for shadowing, instead of hardcoding
