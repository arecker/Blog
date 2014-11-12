Title: Style
Description: Style talk - programming style that is.  What does your programming style say about your stance on moral responsibility?
Image: https://www.python.org/~guido/images/IMG_2192.jpg
Date: 8-26-2014

Hi, readership.  Today, we are going to talk about style.  I don’t mean the standard Isaac Mizrahi kind.  In no way am I qualified to do that.  I hope I don’t lose 80% of you when I say this, but I have a few notes on programming style.  You can take me at my word that I am very comfortable with the possibility that I am walking around in a world where some people think programming is stupid.  I would never try to shove anything that tastes like math class down your throat.  I totally get it.  I won’t eat red onions or listen to Maroon 5.  But I wouldn’t bring you something from the world of programming if I didn’t think you would benefit from it in your world.

# I suck at programming
I’m objectively still a horrible programmer.  Up past my junior year of college, I didn’t use my Macbook Pro for anything beyond something to charge my phone with.   I picked up most things in a late night frenzy when I should have been studying for something more closely related to my diploma.  I made a lot of assumptions, developed a lot of habits, and tread with haste through the quiet, sacred temples of human-computer interface.

Consequently, I received a lot of criticism for the way I code - as I totally should have.  That’s the best way to learn.  At my work, we do all our programming in pairs.  Generally, one engineer “drives”, while the other acts as the “spotter”.  If you are one of those people who take criticism personally, the practice would no doubt send you into a frenzy.  Imagine someone sitting over your shoulder pointing out all your typos while you are proofreading somebody’s Algebra II homework, and you are pretty much there.  If you are like me, however, that doesn’t sound so bad.  I think you should have no problem defending your cool, calm, collected self when you are right about something, just as long as you realize you yourself can make mistakes too.  Working in pairs is a lot of fun once you get comfortable with the idea that you are probably going to be wrong 50% of the time.

But I digress.  I was talking about programming style.  While another programmer is working, the only reason his parter should interrupt him is if he uses *bad style*.

So what’s wrong?  Not enough emoticons?  Too many 1's and not enough 0's?  Good programming style is difficult to define in a vacuum, but everyone can spot it when it's not observed.  Bad style is simply *code that could be better*.

Silly variable names, being inconsistent, showboating an obscure function you learned - most people agree that these are all bad style.  Just take a look at my Comp Sci 101 homework while I was going through... a phase...

    import java.util.*;
    public class AlexIO {

        public static int getInt(String prompt){
            Scanner sc = new Scanner(System.in);
            int ireallymisstheshowjohnnybravoiwonderificanfindfreecopiesofitonline = 0;
            boolean error=true;
            while (error){
                error=false;
                System.out.print(prompt);
                try {
                    ireallymisstheshowjohnnybravoiwonderificanfindfreecopiesofitonline = sc.nextInt();
                } catch (InputMismatchException e){
                    sc.nextLine();
                    System.out.println("Stop screwing around.");
                    error=true;
                }
            }

            return ireallymisstheshowjohnnybravoiwonderificanfindfreecopiesofitonline;

        }

        public static String getString(String prompt){
            Scanner sc = new Scanner(System.in);
            String heySnyder=null;
            boolean error=true;
            while (error){
                error=false;
                System.out.print(prompt);
                try {
                    heySnyder = sc.nextLine();
                } catch (InputMismatchException e){
                    sc.nextLine();
                    System.out.println("Stop screwing around.");
                    error=true;
                }
            }

            return heySnyder;

        }

        public static double getDouble(String prompt){
            Scanner sc = new Scanner(System.in);
            double sexyBeast=0;
            boolean jerrySeinfeld=true;
            while (jerrySeinfeld){
                jerrySeinfeld=false;
                System.out.print(prompt);
                try {
                    sexyBeast = sc.nextDouble();
                } catch (InputMismatchException NEWMAN){
                    sc.nextLine();
                    System.out.println("Cut it out!");
                    jerrySeinfeld=true;
                }
            }

            return sexyBeast;

        }
 
    }

God bless my patient, saint of a TA.  Here is the moral of the story: programs that could be written better constitute *bad style*.  For whatever reason, they don’t get the job done effectively.  My arrogant mess above was a simple group of functions meant to get console input from a user.  Instead of returning variables named after friends, celebrities, and lost cartoons, I could have just used normal words and saved a programmer several minutes of precious mental effort.

Everyone can simply point out when things could be better, but things get interesting when you ask them to elaborate.  Let’s take the example above and bring it before two seasoned programmers (it would have been three, but the third hung himself when he heard I was hired out of college).

**Programmer 1:**

> This is a horrible program.  My first thought is maintainability.  Say this code makes it into a much larger program and goes unnoticed for years.  If there ever came a time where it needed to be modified, the silly variable names would confuse the program flow and make it harder to comprehend.  Precious man hours would be spent trying to understand a program that could have been written more efficiently.  Meanwhile, bugs are occurring, data is corrupted, and it gets increasingly more difficult to improve.  Bad style.

Yikes.  That was harsh.  He must be one of those guys who is *functionally* driven.  Everything is about the amount of work it will take to maintain something.  Programmer 1 is offended at how much time will be wasted trying to figure out what the original programmer meant.  Let’s hear from programmer 2.

**Programmer 2:**
> This is a joke right?  Of course it’s terrible.  I don’t know what he is talking about.  He is clearly having fun, but if only he knew how many people would be depending on this program!  I feel like the author wasted an opportunity to come up with a more readable, elegant solution.  This is just bad style.  Here, let me show you a better way.

The difference is subtle - perhaps a little too subtle for my role-playing to capture.  But what I was trying to show was the difference between the functional programmer’s and idealist programmer's concerns.  Programmer 1 was a *functionalist*.  Good code saves time for everyone.  That’s why you automate things in the first place, right?  Good style means code that can be easily read, fixed, and transported.

Programmer 2 was an idealist.  He was more perturbed at how awkward and unclear my program was.  He found it inconsistent, redundant, and pedagogically worthless.  Furthermore, he was quick to offer a more concise and mathematically beautiful way of solving the same problem for someone.

Both programmer’s have no problem disqualifying the same kind of code under the pretense of *bad style*.  Their reasons, however, vary.

# My philosophy hat
I use to hang out with two philosophy majors who were about a star’s weight more thoughtful than I was.  Whenever we were up late talking about something and I wanted to contribute something ridiculous, I would jokingly prequel it with “Allow me to wear my philosophy hat for a second...”.  This meant that if what I said was cool, it ought to be taken seriously, but if it was totally off, they should refrain from making fun of me because I don’t actually study philosophy.

This time, reader, I tip my philosophy hat to you.  This whole *functional vs ideal* thing reminds me of something I think I may have learned.

The topic of pragmatism vs idealism steers the discussion of morality.  It is nicely parallel with the discussion of programming style we are having today.  Are we moral people simply because our society *functions* better that way?  Admittedly, Christmas shopping and visiting the post office goes much more smoothly when murder and arson are discouraged.  I’ve always assumed that whenever a BestBuy employee refrains from murdering me, it’s mostly because he doesn’t want to get my blood all over his khakis.  There is a great deal of truth to this - our society works better when we follow rules.  Children are happier when their parents are faithful to each other, employees keep their jobs when companies don’t commit crimes... the functional argument works.

Likewise, a good amount of us practice morality because we are following a standard.  We have a good idea of what a perfect and moral life looks like, and we measure our own morality by a perfect standard.  When we fall short, we are dismayed at the wasted opportunity to become a little more like our standard of perfection.

The division in programming is compelling - especially when you find languages that radically lean to one side over the other.

I like to work a lot in a language called *python*.  One thing that is unique about it is that *indenting* matters.  Each nested operation is indented by 4 spaces.  If 3, 5, or a standard *tab* is used instead, your program crashes.  This ensures that all programs are written the same way - readable and consistent.  The language is also rolled together with *The Zen of Python*, which are rules the perfect program must follow.

Python is heavily idealistic.  Bad style is a program that fails to be *pythonic* (don’t say that to a C++ developer.  You may get kicked in the groin).

![‘There should be one-- and preferably only one --obvious way to do it.  Although that way may not be obvious at first unless you are Dutch.’ -Zen of Python](https://www.python.org/~guido/images/IMG_2192.jpg)

On the other side of the spectrum is *Haskell*.  I took a tour in the language about a week ago.  Haskell is purely functional.  Variables cannot change in an expression until it has finished evaluating. One liners, recursion, and mathematical sequences are favored.

# Conclusion
Okay, okay - my philosophy hat is coming off now.  I just found the comparison amusing.  I continue to receive code style critiques, but now (as sort of a personal curiosity) I take a bit of extra time to extract *why* my program exhibits bad style.  Some of us are functionals.  Some of us are idealists.  Some of us are an ongoing bare-knuckle boxing match of both.  Which one are you?