# Funtiply 📚

## Brief
Build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational at their code, but ideally have enough playfulness about them to make kids want to play.

## Requirements
- [x] The player needs to select **which multiplication** tables they want to practice*. This could be pressing `buttons`, or it could be an “Up to…” `stepper`, going from 1 to 12.
- [x] The player should be able to select **how many questions** they want to be asked: 5, 10, 20, or “All”.
- [x] You should randomly generate as many questions as they asked for, within the difficulty range they asked for. 
- [ ] For the “all” case you should generate all possible combinations.

![Reference image](https://i.ibb.co/5rSCcM2/Screen-Shot-2020-12-25-at-18-01-26.png)

## Basic UI
- [x] If you want to go fully down the “education” route then this is going to be some steppers, a text field and a couple of buttons. I would suggest that’s a good place to start, just to make sure you have the basics covered.

## Enhancements
- [ ] You could throw away fixed controls like Stepper entirely if you wanted, and instead rely on colorful buttons to get the same result. 
- [ ] You could use something like [Kenney’s Animal Pack](https://kenney.nl/assets/animal-pack-redux) (which is public domain, by the way!) to add a fun theme to make it into a real game. 
- [ ] You will also add some over the top animations

## Target Age Group
- [ ] It needs to appeal to kids 9 and under, so going bright, colorful, and perhaps even a bit zany is a good idea!

## Tips
- [x] Start with a Single View App template, then add some state to determine whether the game is active or whether you’re asking for settings.
- [x] Because the app has two very different states – “we’re asking the user for settings” and “the game is running” – you should use a `Group` as your top-level view, so that `some View` always gets the same view type being sent back.
- [x] Try and break up your layouts into new SwiftUI views, rather than putting everything in `ContentView`.
- [x] Show the player how many questions they got correct at the end of the game, then offer to let them play again.

## Hints
- [x] You should generate all your questions soon as your game starts, storing them as an array of questions.
- [ ] Those questions should probably be their own Swift struct, `Question`, storing the text and the answer.
- [x] When it comes to asking questions, use another state property called `currentQuestion`, which is an integer pointing at some position in your question array.
- [x] You can get user input either using buttons on the screen, like a calculator, or using a number pad text field – whichever you prefer.
