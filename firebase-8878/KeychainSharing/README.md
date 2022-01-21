# README

This project demonstrates keychain sharing not working as expected on tvOS.   

There are three targets: one for iOS, macOS, and tvOS. Each app shares a simple 
UI consisting of a textfield and three buttons.

- The textfield is for entering a string (for saving in the keychain).
- The **Save password** button saves the textfield's contents to the keychain.
- The **Print saved password... ** button prints the saved password to the console.
- The **Delete saved password** button deletes the saved password to the console.

## Notes
- If you wish to change the saved password, delete it and then save the new password.
- Remember to toggle Xcode's console view to the target you wish to view the console for.
- After modifying the keychain, it make take a few seconds to propogate to the other devices. 

## Repro Steps
1. Sign all targets (adding a Team) and ensure all targets share a common keychain access group (the group should be there).
2. Complete the `FIXME`'s on line 17 in `Shared/KeychainSharingApp.swift`. 
3. Build and run all three apps (better to use hardware over simulator to rule out simulator-related issues).
4. Sign into iCloud on all the devices running the app.
5. Play around with saving a password on one device and reading it from another.
6. You'll notice that the password syncs between iOS and macOS, **but not on tvOS**.
  
