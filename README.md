# rs.ios-stage2-task8
RSSchool iOS, stage 2, task8

### My Solution

![cats1](https://user-images.githubusercontent.com/61166305/136290102-b2ae14a8-5c14-43cd-8c78-512bf2d382b6.png)
![cats2](https://user-images.githubusercontent.com/61166305/136290104-e88a8bf3-79b2-4983-85b5-4eee7d26cfd0.png)
![cats3](https://user-images.githubusercontent.com/61166305/136290112-d14b0012-38ca-44dd-98f0-8760f8271e5d.png)
![cats4](https://user-images.githubusercontent.com/61166305/136290149-4ce75c49-6c4c-4bdd-bbb6-b05a23bf3d89.png)

## Details Task
![Cat's API](https://cdn2.thecatapi.com/logos/thecatapi_256xW.png)

### Downloading and saving cats!


### Use this API: https://docs.thecatapi.com/ to implement the app with the following features:

1. Add logic for passing Authentication (it should be possible to enter a API key "x-api-key")
     1. if user enter a API key "x-api-key", add logic to upload new images
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
