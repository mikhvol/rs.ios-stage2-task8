# rs.ios-stage2-task8
RSSchool iOS, stage 2, task8

![Cat's API](https://cdn2.thecatapi.com/logos/thecatapi_256xW.png)

### Downloading and saving cats!

### Use this API: https://docs.thecatapi.com/ to implement the app with the following features:

1. Add logic for passing Authentication (it should be possible to enter a username and password)
     1. if user enter a username and password, add logic to upload new images
     2. the application should work without authorization also

2. Ability to download and show cats in a list. (Use UICollectionView (Vertical layer))
     1. all loaded images should saved on the cache
     2. if you loaded this image before, get image from cache. No need to download image from the network
  
3. Infinite scrolling (your UICollectionView should upload fresh portion of cats every time it reaches the end)
     1. visually indicate that you are in the process of loading data

4. Detailed view. After clicking the cat in the UICollectionView “full” image should be opened new screen with modal presentation. 

5. User could save the image to the Galery.

6. Use the MVP pattern instead MVC

## Optional:
7. all network layer should be coverage using Unit Tests

## Notes:
  - Feel free to develops the design of the application himself.
  - Feel free to choose any icons from Internet and fonts
  - Your app should support iOS 11 and higher
  - Use ARC
  - Use Autolayout and XIBs, storyboards are not allowed
  - UI should look appropriate in all the devices and orientations
  - No special UI for iPad, it should look like on iPhone (no split view controllers)
