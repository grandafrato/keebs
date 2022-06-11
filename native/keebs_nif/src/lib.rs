use device_query::{DeviceQuery, DeviceState};

#[rustler::nif]
fn get_keyboard() -> Vec<String> {
    DeviceState::new()
        .get_keys()
        .iter()
        .map(|&x| x.to_string())
        .collect::<Vec<String>>()
}

#[rustler::nif]
fn get_mouse_coords() -> (i32, i32) {
    DeviceState::new().get_mouse().coords
}

#[rustler::nif]
fn get_mouse_buttons() -> Vec<bool> {
    DeviceState::new().get_mouse().button_pressed
}

rustler::init!(
    "Elixir.Keebs.NIF",
    [get_keyboard, get_mouse_coords, get_mouse_buttons]
);
