| [![](y18.svg)](https://news.ycombinator.com)| **[Hacker News](news)**[new](newest) | [past](front) | [comments](newcomments) | [ask](ask) | [show](show) | [jobs](jobs) | [submit](submit)| [login](login?goto=item%3Fid%3D37967126)  
---|---|---  
| | [](vote?id=37967126&how=up&goto=item%3Fid%3D37967126)| [What every developer should know about GPU computing](https://codeconfessions.substack.com/p/gpu-computing) ([codeconfessions.substack.com](from?site=codeconfessions.substack.com))  
---|---|---  
| 465 points by [Anon84](user?id=Anon84) [on Oct 21, 2023](item?id=37967126) | [hide](hide?id=37967126&goto=item%3Fid%3D37967126) | [past](https://hn.algolia.com/?query=What%20every%20developer%20should%20know%20about%20GPU%20computing&type=story&dateRange=all&sort=byDate&storyText=false&prefix&page=0) | [favorite](fave?id=37967126&auth=7af9abd9340eee290fb0fa1b1f1ea1d532438ca7) | [176 comments](item?id=37967126)  
|  
  
| ![](s.gif)| [](vote?id=37972884&how=up&goto=item%3Fid%3D37967126)| [dang](user?id=dang) [on Oct 22, 2023](item?id=37972884) | next [[–]](javascript:void\(0\))  
Someone emailed to complain about
this:[https://twitter.com/abhi9u/status/1715753871564476597](https://twitter.com/abhi9u/status/1715753871564476597)That
is against HN's rules. In fact, it's the one thing that's important enough to
be in both the site guidelines and FAQ. HN users feel extremely strongly about
this._Q: Can I ask people to upvote my submission?__A: No. Users should vote
for a story because they personally find it intellectually interesting, not
because someone has content to promote. We penalize or ban submissions,
accounts, and sites that break this rule, so please don
't._[https://news.ycombinator.com/newsfaq.html](https://news.ycombinator.com/newsfaq.html)
_Don 't solicit upvotes, comments, or submissions. Users should vote and
comment when they run across something they personally find interesting—not
for
promotion._[https://news.ycombinator.com/newsguidelines.html](https://news.ycombinator.com/newsguidelines.html)  
---|---|---  
| ![](s.gif)| [](vote?id=37973336&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 22, 2023](item?id=37973336) | parent | next [[–]](javascript:void\(0\))  
Sorry, I was not aware of this rule. Although it was submitted by someone I
don't know.But I won't do it again now that I know.  
---|---|---  
| ![](s.gif)| [](vote?id=37969069&how=up&goto=item%3Fid%3D37967126)| [01100011](user?id=01100011) [on Oct 21, 2023](item?id=37969069) | prev | next [[–]](javascript:void\(0\))  
> Copying Data from Host to DeviceSurprised there's no mention of async copies
> here. If you want to get the most out of the GPU, you don't want it idle
> when copying data between the host and the GPU. Many frameworks provide for
> a mechanism to schedule async copies which can execute along side async work
> submission.The post is sort of GPU 101 but there's a whole world of tricks
> and techniques beyond that once you start doing real-world GPU programming
> where you want to squeeze as much out of the expensive GPU as possible.
> Profiling tools help a lot here because, like much of optimizing now, there
> are hidden cliffs and non-linearities all over that you have to be aware of.  
---|---|---  
| ![](s.gif)| [](vote?id=37970541&how=up&goto=item%3Fid%3D37967126)| [nine_k](user?id=nine_k) [on Oct 21, 2023](item?id=37970541) | parent | next [[–]](javascript:void\(0\))  
Since you likely use 64-bit (double) floats, not every GPU would help much,
especially compared to a beefy CPU.But if you use a GPU with a large number of
FP64 units, it may speed things up a lot. These are generally not gaming GPUs,
but if you have a 4060 sitting around anyway, it has about 300 GFLOPS FP64
performance, likely more than your CPU. Modern CPUs are mighty in this regard
though, able to issue many FP64 operations per clock per core.  
---|---|---  
| ![](s.gif)| [](vote?id=37972376&how=up&goto=item%3Fid%3D37967126)| [01100011](user?id=01100011) [on Oct 22, 2023](item?id=37972376) | root | parent | next [[–]](javascript:void\(0\))  
Did you reply to the wrong comment?  
---|---|---  
| ![](s.gif)| [](vote?id=37969131&how=up&goto=item%3Fid%3D37967126)| [permo-w](user?id=permo-w) [on Oct 21, 2023](item?id=37969131) | prev | next [[–]](javascript:void\(0\))  
>Most programmers have an intimate understanding of CPUsmaybe this article is
brilliant, but when the first line is something so blatantly untrue it really
makes it hard to take the rest seriously  
---|---|---  
| ![](s.gif)| [](vote?id=37969305&how=up&goto=item%3Fid%3D37967126)| [PTOB](user?id=PTOB) [on Oct 21, 2023](item?id=37969305) | parent | next [[–]](javascript:void\(0\))  
Try this on: "A non-trivial number of Computer Scientists, Computer Engineers,
Electrical Engineers, and hobbyists have ..."Took some philosophy courses for
fun in college. I developed a reading skill there that lets me forgive certain
statements by improving them instead of dismissing them. My brain now
automatically translates over-generalizations and even outright falsehoods
into rationally-nearby true statements. As the argument unfolds, those ideas
are reconfigured until the entire piece can be evaluated as logically
coherent.The upshot is that any time I read a crappy article, I'm left with a
new batch of true and false premises or claims about topics I'm interested in.
And thus my mental world expands.  
---|---|---  
| ![](s.gif)| [](vote?id=37969683&how=up&goto=item%3Fid%3D37967126)| [smokel](user?id=smokel) [on Oct 21, 2023](item?id=37969683) | root | parent | next [[–]](javascript:void\(0\))  
That's a refreshing take.I tried real hard to understand what some continental
philosophers, such as Latour, Deleuze, and Žižek are on about, giving some of
their texts quite some benefit of the doubt. After about ten years of doing
so, I am more and more returning to my previous opinion that some of these
just like to talk, and even though they have lots to say, they say so much,
that I still have to do all the actual philosophizing myself.  
---|---|---  
| ![](s.gif)| [](vote?id=37971302&how=up&goto=item%3Fid%3D37967126)| [Karrot_Kream](user?id=Karrot_Kream) [on Oct 21, 2023](item?id=37971302) | root | parent | next [[–]](javascript:void\(0\))  
Philosophy is often called the "Great Conversation" because, as you say, a lot
of it is just people "saying things". Some of these things are incredibly
insightful others are just babbling, the ones that make it into books
generally have a higher ratio of insight to babble. You need to read
philosophy, _especially_ continental philosophy, with a critical eye. If you
aren't chewing on and contemplating (and calling "bullshit") on philosophy as
you read it, you aren't getting out of it what you should.  
---|---|---  
| ![](s.gif)| [](vote?id=37972957&how=up&goto=item%3Fid%3D37967126)| [Dylan16807](user?id=Dylan16807) [on Oct 22, 2023](item?id=37972957) | root | parent | next [[–]](javascript:void\(0\))  
It's one thing to disagree, but if there's a bunch of content-free words
that's just bad writing.  
---|---|---  
| ![](s.gif)| [](vote?id=37970015&how=up&goto=item%3Fid%3D37967126)| [salawat](user?id=salawat) [on Oct 21, 2023](item?id=37970015) | root | parent | prev | next [[–]](javascript:void\(0\))  
The Ur subject of philosophy is not the writing and reading of philosophy, but
to exercise the mind in coming to grips with that which we have no conception
of yet. Language is it's medium, and the IO is those texts. However the nugget
at the center is figuring out that magic blackbox that lets you take all the
dead ends in those texts and divine a reasonable guiding principle or
recognition of an end to the space of tread discourse.To that end, you have to
approach philosophical reading with a degree of hypothetical detachment that
not everyone is immediately comfortable with.  
---|---|---  
| ![](s.gif)| [](vote?id=37970310&how=up&goto=item%3Fid%3D37967126)| [crooked-v](user?id=crooked-v) [on Oct 21, 2023](item?id=37970310) | root | parent | next [[–]](javascript:void\(0\))  
The Tao Te Ching opens with almost exactly that subject... though, of course,
it also makes you think about it a while first to understand what it's getting
at.  
---|---|---  
| ![](s.gif)| [](vote?id=37970835&how=up&goto=item%3Fid%3D37967126)| [runlaszlorun](user?id=runlaszlorun) [on Oct 21, 2023](item?id=37970835) | root | parent | next [[–]](javascript:void\(0\))  
Aha, nice connection! I'm a fan of the Tao Te Ching but never would've caught
that one my own. Thx!  
---|---|---  
| ![](s.gif)| [](vote?id=38026598&how=up&goto=item%3Fid%3D37967126)| [nn_m](user?id=nn_m) [on Oct 26, 2023](item?id=38026598) | root | parent | prev | next [[–]](javascript:void\(0\))  
Thanks so much for sharing this. I'm watching a self described "politicsl
philosopher" on yTube. (The talks are labeled as chats, are not scripted,
although he has separate channel that offers scripted material)The "chats" are
usually edifying, but I am often frustrated by the rambling and repetition (He
is always trying to bring in new listeners, so that partly explains the
repetition)But from my own (arm chair politcal organizer) point of view, i'm
thinking "you have ~10 very good key points you touch on/repeat over time, why
not be a more effective communicator, make this visual as well as verbal and
turn this into a message. I.e. bullet points that are always close at hand and
that you're l using to tie the talk together."But that's basically propaganda
main tool.So thanks for sharing your effort and discipline in going to the
philosophy classes. Your more expansive approach to what people aay chimes
very much with my yT mentor's reminder to listen 99% and judge 1%.Dont try to
win every argument or prove your point of view is right. Others are entitled
to their (wrong (-; ) opinions (just as if we think back to our changing
points of view, we have been "wrong" in the past too. Judge yee not ....)By
continuing to listen to those we don't agree with we are putting a face to
ideas they dont accept or understand (it is easier to stay in your own bubble
when you are only looking/hearing people that you agree with) AND by listening
respectfully we are keeping the lines of communication open.  
---|---|---  
| ![](s.gif)| [](vote?id=37971243&how=up&goto=item%3Fid%3D37967126)| [heyoni](user?id=heyoni) [on Oct 21, 2023](item?id=37971243) | root | parent | prev | next [[–]](javascript:void\(0\))  
I feel like that would slow down my reading so hard…and I’m already a slow
reader :(  
---|---|---  
| ![](s.gif)| [](vote?id=37969258&how=up&goto=item%3Fid%3D37967126)| [anonporridge](user?id=anonporridge) [on Oct 21, 2023](item?id=37969258) | parent | prev | next [[–]](javascript:void\(0\))  
Definitely not true about most programmers, but maybe the author meant CS
educated engineers. Going through a formal CS program will give you an
intimate understanding of CPUs, especially when compared to the very light
coverage of GPUs.  
---|---|---  
| ![](s.gif)| [](vote?id=37972052&how=up&goto=item%3Fid%3D37967126)| [p1esk](user?id=p1esk) [on Oct 22, 2023](item?id=37972052) | root | parent | next [[–]](javascript:void\(0\))  
_Going through a formal CS program will give you an intimate understanding of
CPUs_ Please tell me you forgot the /s.I have a PhD in computer engineering
from a top-20 school in US. Took a bunch of grad level classes, passed the
quals (my specialty was ML accelerators).I do NOT have an “intimate
understanding of CPUs”. I probably know a little bit more about CPUs than an
average programmer. Which is very little.Modern CPUs are extremely complex.
Almost as much of impenetrable black boxes as modern neural networks.  
---|---|---  
| ![](s.gif)| [](vote?id=37972738&how=up&goto=item%3Fid%3D37967126)| [gmadsen](user?id=gmadsen) [on Oct 22, 2023](item?id=37972738) | root | parent | next [[–]](javascript:void\(0\))  
I think the intention of the phrase, is that most cs programs include a
systems course. you will learn von neumann arch, with cpu including
{registers, clock, ALUs, etc}. Obviously modern CPUs have a lot more
complexity, but even the basic coverage of CPUs is more coverage than GPUS.  
---|---|---  
| ![](s.gif)| [](vote?id=37973081&how=up&goto=item%3Fid%3D37967126)| [p1esk](user?id=p1esk) [on Oct 22, 2023](item?id=37973081) | root | parent | next [[–]](javascript:void\(0\))  
Everything you learn about CPUs in your CS undergrad program is applicable to
GPUs. Both are examples of von Neumann architecture, both have registers,
ALUs, ISA, instruction schedulers, cache hierarchy, external DRAM, etc. The
main difference is how they are being used - GPU, while a general purpose
computer, is typically used as an accelerator for specific workloads, and it
needs CPU to function. The distinction between the two is getting blurred as
GPUs get better at executing control flows, and CPUs get more cores and wider
vector operations.  
---|---|---  
| ![](s.gif)| [](vote?id=37970960&how=up&goto=item%3Fid%3D37967126)| [tester756](user?id=tester756) [on Oct 21, 2023](item?id=37970960) | root | parent | prev | next [[–]](javascript:void\(0\))  
"Going through a formal CS program will give you an intimate understanding of
CPUsand 101 other hilarious jokes you can tell yourself!"  
---|---|---  
| ![](s.gif)| [](vote?id=37971169&how=up&goto=item%3Fid%3D37967126)| [chpatrick](user?id=chpatrick) [on Oct 21, 2023](item?id=37971169) | root | parent | next [[–]](javascript:void\(0\))  
Depends on the university!In my school to pass the computer architecture
course you had to read and present a recent paper on CPU design.  
---|---|---  
| ![](s.gif)| [](vote?id=37972016&how=up&goto=item%3Fid%3D37967126)| [PeterisP](user?id=PeterisP) [on Oct 22, 2023](item?id=37972016) | root | parent | next [[–]](javascript:void\(0\))  
Which most of these students will have entirely forgotten a few years after
graduation - use it or lose it.  
---|---|---  
| ![](s.gif)| [](vote?id=37972378&how=up&goto=item%3Fid%3D37967126)| [tantalor](user?id=tantalor) [on Oct 22, 2023](item?id=37972378) | root | parent | prev | next [[–]](javascript:void\(0\))  
That's a lot to ask of an undergrad  
---|---|---  
| ![](s.gif)| [](vote?id=37972610&how=up&goto=item%3Fid%3D37967126)| [latency-guy2](user?id=latency-guy2) [on Oct 22, 2023](item?id=37972610) | root | parent | next [[–]](javascript:void\(0\))  
Maybe a modern one for a degree mill that cares not for breadth or depth. It
really shouldn't be otherwise.I'm very confident in people having the ability
to read by the time they are in college. And considering that summarizing a
research paper doesn't even have to be perfect, plus very little need to
scrutinize the experiment itself, undergrads should be able to do
that.Otherwise they don't belong in college.  
---|---|---  
| ![](s.gif)| [](vote?id=37973661&how=up&goto=item%3Fid%3D37967126)| [pezezin](user?id=pezezin) [on Oct 22, 2023](item?id=37973661) | root | parent | prev | next [[–]](javascript:void\(0\))  
In my school we had to implement a toy 16-bit CPU in VHDL.  
---|---|---  
| ![](s.gif)| [](vote?id=37974243&how=up&goto=item%3Fid%3D37967126)| [PartiallyTyped](user?id=PartiallyTyped) [on Oct 22, 2023](item?id=37974243) | root | parent | next [[–]](javascript:void\(0\))  
Same! Fun times in the labs!  
---|---|---  
| ![](s.gif)| [](vote?id=37970009&how=up&goto=item%3Fid%3D37967126)| [usea](user?id=usea) [on Oct 21, 2023](item?id=37970009) | root | parent | prev | next [[–]](javascript:void\(0\))  
> Going through a formal CS program will give you an intimate understanding of
> CPUsI did an undergrad in CS, where I did well. I don't feel like I
> understand CPUs very well. Certainly not anywhere in the realm of
> "intimate."  
---|---|---  
| ![](s.gif)| [](vote?id=37969301&how=up&goto=item%3Fid%3D37967126)| [croes](user?id=croes) [on Oct 21, 2023](item?id=37969301) | root | parent | prev | next [[–]](javascript:void\(0\))  
Maybe a generation thing, I remember reading Michael Abrash's Graphics
Programming Black Book and learning a lot about cycle eaters in the CPU.  
---|---|---  
| ![](s.gif)| [](vote?id=37972098&how=up&goto=item%3Fid%3D37967126)| [jandrewrogers](user?id=jandrewrogers) [on Oct 22, 2023](item?id=37972098) | root | parent | prev | next [[–]](javascript:void\(0\))  
For anyone that needs to know how a CPU works for performance engineering
similar to a GPU, the details of the microarchitecture matter a lot even
within the same ISA. I am not aware of any formal CS program that teaches
anyone the nuanced internals of various microarchitecture designs. Everyone I
know with this knowledge appears to be self-taught regardless of where they
went to school.I think the descriptor “intimate” is overstating the case if
you don’t know how to optimize code on different implementations of the same
ISA. Most formal CS programs give you a generic understanding of CPUs, more
like a survey course, not enough information to do serious optimization.  
---|---|---  
| ![](s.gif)| [](vote?id=37972880&how=up&goto=item%3Fid%3D37967126)| [pca006132](user?id=pca006132) [on Oct 22, 2023](item?id=37972880) | root | parent | next [[–]](javascript:void\(0\))  
I am really curious about what kind of optimizations are enabled when you know
the microarchitectural design of various CPUs, but without writing assembly by
hand. I only know the basics such as optimizing data structure for better
cache locality, add some fast paths, manual unrolling, but have no idea about
how to work around things like pipeline stalls. It would be really helpful if
you can point to some materials about this!  
---|---|---  
| ![](s.gif)| [](vote?id=37977143&how=up&goto=item%3Fid%3D37967126)| [jandrewrogers](user?id=jandrewrogers) [on Oct 22, 2023](item?id=37977143) | root | parent | next [[–]](javascript:void\(0\))  
The basic principle is that a CPU core is a complex distributed system with
varying degrees of parallelism, concurrency, and latency as all of these
components communicate with each other. The design of this distributed system
varies across microarchitectures as do the available features. Analyzing the
optimal codegen is similar to analyzing optimal algorithm design in higher
level distributed systems with a fixed hardware specification.Compilers are
good at finding very local optimizations targeting specific
microarchitectures. If you use godbolt and switch out the architecture flags
you can see how the codegen changes.However, as with higher level code, the
compiler can’t rewrite your data structures or see patterns spread across too
much code. As a simple example, modern cores have 4+ concurrent ALUs with
different capabilities. Some of those ALUs are usually idle if there are not
enough independent instructions or independent instructions are too far away
from the current instruction. You can see large performance improvements
simply by reorganizing your C code so that the compiler and CPU can see more
opportunities to use more ALUs in parallel. Interestingly, a lot of these code
changes are trivial no-ops at the code semantics level, but they bring the ALU
concurrency opportunity within view of the CPU.There is an active niche
community on the Internet that studies how various instruction sequences
interact with various microarchitectures. This is probably the best resource
because a lot of detail is not well documented by the CPU companies
themselves. It requires a fair amount of experimentation to develop an
intuition for how code will run on a given CPU at this level of detail.  
---|---|---  
| ![](s.gif)| [](vote?id=37999512&how=up&goto=item%3Fid%3D37967126)| [protomolecule](user?id=protomolecule) [on Oct 24, 2023](item?id=37999512) | root | parent | next [[–]](javascript:void\(0\))  
"There is an active niche community on the Internet that studies how various
instruction sequences interact with various microarchitectures. This is
probably the best resource"Could elaborate on that? I mean where do I find
this community?  
---|---|---  
| ![](s.gif)| [](vote?id=37970262&how=up&goto=item%3Fid%3D37967126)| [galangalalgol](user?id=galangalalgol) [on Oct 21, 2023](item?id=37970262) | root | parent | prev | next [[–]](javascript:void\(0\))  
Are most programmers self trained now? I can see if someone self trains for fe
or even full stack with an eye on compensation, they wouldn't understand
program counters and the like. But so many people seem motivated by video
games to get into the industry that I'd expect them to be reading about things
like the fast inverse square root or similar.  
---|---|---  
| ![](s.gif)| [](vote?id=37970340&how=up&goto=item%3Fid%3D37967126)| [crooked-v](user?id=crooked-v) [on Oct 21, 2023](item?id=37970340) | root | parent | next [[–]](javascript:void\(0\))  
A lot of game dev now happens in high-level engines, often with their own
extra layer of scripting engine. Even working on the nitty-gritty of spatial
logic rather than using engine-based colliders/detection would be pretty rare.  
---|---|---  
| ![](s.gif)| [](vote?id=37970515&how=up&goto=item%3Fid%3D37967126)| [galangalalgol](user?id=galangalalgol) [on Oct 21, 2023](item?id=37970515) | root | parent | next [[–]](javascript:void\(0\))  
So are we really losing knowledge or just specializing ever more down the
fractal?  
---|---|---  
| ![](s.gif)| [](vote?id=37970808&how=up&goto=item%3Fid%3D37967126)| [hombre_fatal](user?id=hombre_fatal) [on Oct 21, 2023](item?id=37970808) | root | parent | next [[–]](javascript:void\(0\))  
I think it's just that you don't need to be intimate with lower level details
to deliver more value at higher levels like game and application dev.If your
day to day involves "intimate knowledge with the CPU" and bumping program
counters, I can rule out a lot of things that you probably aren't building,
like a compelling iOS app or forum HTTP server, for example.Maybe you're doing
impressive work on emulators or something though. But it's nothing to get
pompous about just because other people don't share that interest.We too
easily go off careening into a circlejerk.  
---|---|---  
| ![](s.gif)| [](vote?id=37970726&how=up&goto=item%3Fid%3D37967126)| [c2lsZW50](user?id=c2lsZW50) [on Oct 21, 2023](item?id=37970726) | root | parent | prev | next [[–]](javascript:void\(0\))  
I believe the answer is depends, but there were some interesting discussions
today under an article which relates to
this.[https://news.ycombinator.com/item?id=37965142](https://news.ycombinator.com/item?id=37965142)  
---|---|---  
| ![](s.gif)| [](vote?id=37971185&how=up&goto=item%3Fid%3D37967126)| [twixfel](user?id=twixfel) [on Oct 21, 2023](item?id=37971185) | parent | prev | next [[–]](javascript:void\(0\))  
I don't understand why every other submission on the internet has to have at
least one "stopped reading at X" comment relating to it. It adds absolutely
nothing.  
---|---|---  
| ![](s.gif)| [](vote?id=37972346&how=up&goto=item%3Fid%3D37967126)| [permo-w](user?id=permo-w) [on Oct 22, 2023](item?id=37972346) | root | parent | next [[–]](javascript:void\(0\))  
I regret the way I phrased it. it's snarky and not in the spirit of curiosity,
but I do think it's worth discussing that the author thinks that most
programmers know how a CPU works  
---|---|---  
| ![](s.gif)| [](vote?id=37971458&how=up&goto=item%3Fid%3D37967126)| [abadpoli](user?id=abadpoli) [on Oct 21, 2023](item?id=37971458) | root | parent | prev | next [[–]](javascript:void\(0\))  
It provides feedback to the author, and it also has generated quite a
significant discussion here about the topic.It could have been worded more
constructively sure, but given that the entire point of this website is to
have discussions about the material posted, I think it’s added quite a bit.  
---|---|---  
| ![](s.gif)| [](vote?id=37971825&how=up&goto=item%3Fid%3D37967126)| [squeaky-clean](user?id=squeaky-clean) [on Oct 22, 2023](item?id=37971825) | root | parent | next [[–]](javascript:void\(0\))  
It hasn't really generated any discussion about the topic at hand though. Just
people discussing what they learned or didn't learn about CPUs in school.  
---|---|---  
| ![](s.gif)| [](vote?id=37971866&how=up&goto=item%3Fid%3D37967126)| [moritzwarhier](user?id=moritzwarhier) [on Oct 22, 2023](item?id=37971866) | parent | prev | next [[–]](javascript:void\(0\))  
I think at least 50% of the answers of this would depend on how one defines
"intimate understanding"...I learned basic facts about CPU architectures at
university, know in a very basic way the landscape of things and occasionaly
stumble upon updates to my limited knowledge... but by no means would I say
that, rather like "a basic understanding of how CPUs work / are designed / are
to be used" (?)If I were proficient in assembler, maybe I'd claim to have an
"intimate understanding" of how to _use_ CPUs at a low level (still sounds a
bit braggy)It still is not the same though as being an expert in CPU/GPU
design.So yeah I agree.Article is interesting though, esp. the diagram!  
---|---|---  
| ![](s.gif)| [](vote?id=37971417&how=up&goto=item%3Fid%3D37967126)| [rjh29](user?id=rjh29) [on Oct 21, 2023](item?id=37971417) | parent | prev | next [[–]](javascript:void\(0\))  
I learned it both in my degree and the Structure and Interpretation of
Computer Programs course (which I recommend to anyone interested in low level
computing)  
---|---|---  
| ![](s.gif)| [](vote?id=37973444&how=up&goto=item%3Fid%3D37967126)| [njacobs5074](user?id=njacobs5074) [on Oct 22, 2023](item?id=37973444) | parent | prev | next [[–]](javascript:void\(0\))  
Agree that saying "intimate understanding" is a bit off the mark. Had the
author written "intuitive understanding", it would have made a bit more
sense.However, given the prevalence of the von Neumann computing architecture,
I don't think it's completely off the mark - even if people don't know von
Neumann's name :)  
---|---|---  
| ![](s.gif)| [](vote?id=37969286&how=up&goto=item%3Fid%3D37967126)| [kalak](user?id=kalak) [on Oct 21, 2023](item?id=37969286) | parent | prev | next [[–]](javascript:void\(0\))  
feels very much like [https://xkcd.com/2501/](https://xkcd.com/2501/)  
---|---|---  
| ![](s.gif)| [](vote?id=37970223&how=up&goto=item%3Fid%3D37967126)| [ashu](user?id=ashu) [on Oct 21, 2023](item?id=37970223) | parent | prev | next [[–]](javascript:void\(0\))  
And this is the most insightful thing you had to say about this?! Pfft.  
---|---|---  
| ![](s.gif)| [](vote?id=37968939&how=up&goto=item%3Fid%3D37967126)| [Const-me](user?id=Const-me) [on Oct 21, 2023](item?id=37968939) | prev | next [[–]](javascript:void\(0\))  
> During execution the registers allocated to a thread are private to it,
> i.e., other threads cannot read/write those registers.Wave intrinsics in
> HLSL, and similar CUDA things can read registers from different threads
> within the current wavefront.Also, in the paragraph about memory
> architecture, I would mention the caches provide no coherency guarantees
> across threads of the same dispatch/grid, but there’s a special functional
> block global to the complete chips which implements atomics on global
> memory.  
---|---|---  
| ![](s.gif)| [](vote?id=37969418&how=up&goto=item%3Fid%3D37967126)| [paulddraper](user?id=paulddraper) [on Oct 21, 2023](item?id=37969418) | prev | next [[–]](javascript:void\(0\))  
SIMD programming is f---ing wild.Want to run a calculation for every pixel on
your screen? No problem.Want to have a branching condition? Ouchie.  
---|---|---  
| ![](s.gif)| [](vote?id=37969437&how=up&goto=item%3Fid%3D37967126)| [eimrine](user?id=eimrine) [on Oct 21, 2023](item?id=37969437) | parent | next [[–]](javascript:void\(0\))  
Want to have eval? Stop everything.  
---|---|---  
| ![](s.gif)| [](vote?id=37969630&how=up&goto=item%3Fid%3D37967126)| [touisteur](user?id=touisteur) [on Oct 21, 2023](item?id=37969630) | root | parent | next [[–]](javascript:void\(0\))  
Vectorized emulation is very interesting and fun, Brandon Falk (gamozolabs)
has this series of hours-long streams and rust projects, you can start here:
[https://news.ycombinator.com/item?id=18222729](https://news.ycombinator.com/item?id=18222729)  
---|---|---  
| ![](s.gif)| [](vote?id=37988802&how=up&goto=item%3Fid%3D37967126)| [winwang](user?id=winwang) [on Oct 23, 2023](item?id=37988802) | parent | prev | next [[–]](javascript:void\(0\))  
To be fair, this makes sense: making a smart decision is "harder" than scaling
a simple calculation out to a bunch of workers.  
---|---|---  
| ![](s.gif)| [](vote?id=37969039&how=up&goto=item%3Fid%3D37967126)| [toppy](user?id=toppy) [on Oct 21, 2023](item?id=37969039) | prev | next [[–]](javascript:void\(0\))  
Why are they still called GPU? PPU (Parallel Processing Unit) sounds like a
better name.  
---|---|---  
| ![](s.gif)| [](vote?id=37971167&how=up&goto=item%3Fid%3D37967126)| [Salgat](user?id=Salgat) [on Oct 21, 2023](item?id=37971167) | parent | next [[–]](javascript:void\(0\))  
Because they're filled with graphics specific silicon in addition to the GPGPU
stuff.  
---|---|---  
| ![](s.gif)| [](vote?id=37970403&how=up&goto=item%3Fid%3D37967126)| [dist-epoch](user?id=dist-epoch) [on Oct 21, 2023](item?id=37970403) | parent | prev | next [[–]](javascript:void\(0\))  
Because everybody understands what you mean when you say GPU.Same with drone
versus quad-copter, etc...  
---|---|---  
| ![](s.gif)| [](vote?id=37970916&how=up&goto=item%3Fid%3D37967126)| [palata](user?id=palata) [on Oct 21, 2023](item?id=37970916) | root | parent | next [[–]](javascript:void\(0\))  
To be pedantic, a quadcopter is a drone, but a drone is not necessarily a
quadcopter.  
---|---|---  
| ![](s.gif)| [](vote?id=37971175&how=up&goto=item%3Fid%3D37967126)| [dragonwriter](user?id=dragonwriter) [on Oct 21, 2023](item?id=37971175) | root | parent | next [[–]](javascript:void\(0\))  
To be even more pedantic, "quadcopter" is a statement about airframe layout,
and "drone" is a statement about control, and neither necessarily implies the
other. You can have a non-drone quadcopter [0] or a non-quadcopter drone
[1].[0] e.g., [https://www.jetsonaero.com/jetson-
one](https://www.jetsonaero.com/jetson-one)[1] e.g.,
[https://en.wikipedia.org/wiki/HESA_Shahed_136](https://en.wikipedia.org/wiki/HESA_Shahed_136)  
---|---|---  
| ![](s.gif)| [](vote?id=37974924&how=up&goto=item%3Fid%3D37967126)| [palata](user?id=palata) [on Oct 22, 2023](item?id=37974924) | root | parent | next [[–]](javascript:void\(0\))  
Haha touché :-).  
---|---|---  
| ![](s.gif)| [](vote?id=37977019&how=up&goto=item%3Fid%3D37967126)| [croes](user?id=croes) [on Oct 22, 2023](item?id=37977019) | root | parent | prev | next [[–]](javascript:void\(0\))  
We still call smartphones phones but hardly use the phone functionality.  
---|---|---  
| ![](s.gif)| [](vote?id=37969498&how=up&goto=item%3Fid%3D37967126)| [speed_spread](user?id=speed_spread) [on Oct 21, 2023](item?id=37969498) | parent | prev | next [[–]](javascript:void\(0\))  
Vector Processing Unit would be more appropriate.  
---|---|---  
| ![](s.gif)| [](vote?id=37969560&how=up&goto=item%3Fid%3D37967126)| [KeplerBoy](user?id=KeplerBoy) [on Oct 21, 2023](item?id=37969560) | root | parent | next [[–]](javascript:void\(0\))  
Why stop there? Matrix Processing Unit or Tensor Processing Unit if you want
to trigger the physicists or are a fan of the google cloud.  
---|---|---  
| ![](s.gif)| [](vote?id=37970080&how=up&goto=item%3Fid%3D37967126)| [speed_spread](user?id=speed_spread) [on Oct 21, 2023](item?id=37970080) | root | parent | next [[–]](javascript:void\(0\))  
Those things actually exists and are called NPU (Neural Processing Unit). Many
recent ARM CPU have them (Apple, Qualcomm, etc.) and even new RISC-V CPU.
They're different from GPU in being even more constrained in programming
requiring usage of a fixed function vendor-supplied library.  
---|---|---  
| ![](s.gif)| [](vote?id=37971138&how=up&goto=item%3Fid%3D37967126)| [dragonwriter](user?id=dragonwriter) [on Oct 21, 2023](item?id=37971138) | root | parent | prev | next [[–]](javascript:void\(0\))  
Those are a different thing (which may be part of a GPU, e.g., Nvidia's Tensor
Cores, or separate, e.g., Apple Neural Engine.)  
---|---|---  
| ![](s.gif)| [](vote?id=37969785&how=up&goto=item%3Fid%3D37967126)| [nologic01](user?id=nologic01) [on Oct 21, 2023](item?id=37969785) | root | parent | prev | next [[–]](javascript:void\(0\))  
Differential Geometric Processing Unit would do it for me.  
---|---|---  
| ![](s.gif)| [](vote?id=37969306&how=up&goto=item%3Fid%3D37967126)| [croes](user?id=croes) [on Oct 21, 2023](item?id=37969306) | parent | prev | next [[–]](javascript:void\(0\))  
CPUs are PPUs too  
---|---|---  
| ![](s.gif)| [](vote?id=37971118&how=up&goto=item%3Fid%3D37967126)| [rational_indian](user?id=rational_indian) [on Oct 21, 2023](item?id=37971118) | root | parent | next [[–]](javascript:void\(0\))  
A better name for GPUs would then be "Massively parallel processing units" or
MPPUs.  
---|---|---  
| ![](s.gif)| [](vote?id=37971567&how=up&goto=item%3Fid%3D37967126)| [toppy](user?id=toppy) [on Oct 21, 2023](item?id=37971567) | root | parent | prev | next [[–]](javascript:void\(0\))  
Touche!  
---|---|---  
| ![](s.gif)| [](vote?id=37969905&how=up&goto=item%3Fid%3D37967126)| [duckmysick](user?id=duckmysick) [on Oct 21, 2023](item?id=37969905) | parent | prev | next [[–]](javascript:void\(0\))  
General Processing Unit  
---|---|---  
| ![](s.gif)| [](vote?id=37969141&how=up&goto=item%3Fid%3D37967126)| [zackmorris](user?id=zackmorris) [on Oct 21, 2023](item?id=37969141) | prev | next [[–]](javascript:void\(0\))  
This is a great writeup. And GPUs are more advanced/performant for what they
do than anything I could ever come up with.But I put SIMD in the category of
something that isn't necessary once one has learned other (more flexible)
paradigms. I prefer MIMD and clusters/transputers, which seem to have died out
by the 2000s. Today's status quo puts the onus on developers to move data
manually, write shaders under arbitrary limitations on how many memory
locations can be accessed simultaneously, duplicate their work with separate
languages for GPU/CPU, know if various hardware is available for stuff like
ray tracing, get locked into opinionated frameworks like OpenGL/Metal/Vulkan,
etc etc etc. GPUs are on a side tangent that can never get me to where I want
to go, so my experience over the last 25 years has been of a person living on
the wrong timeline. I've commented about it extensively but it just feels like
yelling into the void now.Loosely, a scalable general purpose CPU working
within the limitations of the end of Moore's law is multicore with local
memories, sharing data through a copy-on-write content-addressable memory or
other caching scheme which presents a single unified address space to allow
the user to freely explore all methods of computation in a desktop computing
setting. It uses standard assembly language but is usually programmed with
something higher level like Erlang/Go, Octave/MATLAB or ideally a functional
programming language like Julia. 3D rendering and AI libraries are written as
a layer above that, they aren't fundamental.It's interesting that GPUs have
arrived at roughly the multicore configuration that I spoke of, but with
drivers that separate the user from the bare-metal access needed to do general
purpose MIMD. I had thought that FPGAs were the only way to topple GPU
dominance, but maybe there is an opportunity here to write a driver that
presents GPU hardware as MIMD with a unified memory. I don't know how well GPU
cores handle integer math, but that could be approximated with the 32 bit int
portion of a 64 bit float. Those sorts of tradeoffs may result in a MIMD
machine running 10-100 times slower than a GPU, but still 10-100 times faster
than a CPU. But scalable without the over-reliance on large caches and fast
busses which stagnated CPUs since around 2007 when affordability and power
efficiency took priority over performance due to the mobile market taking
over. And MIMD machines can be clustered and form distributed compute networks
like SETI@home with no changes to the code. To get a sense of how empowering
that could be to the average user: it's like comparing BitTorrent to FTP, but
for compute instead of data.  
---|---|---  
| ![](s.gif)| [](vote?id=37972018&how=up&goto=item%3Fid%3D37967126)| [guidedlight](user?id=guidedlight) [on Oct 22, 2023](item?id=37972018) | prev | next [[–]](javascript:void\(0\))  
One thing I don’t understand is how the architecture of Apple Silicon is
different from NVidia’s.Looking at this quote:> the Nvidia H100 GPU has 132
SMs with 64 cores per SM, totalling a whopping 8448 cores.8448 cores sure
sounds impressive. But the Apple M2 Ultra only has 76 cores?!How can the
NVidia H100 GPU have over 110x more cores? Clearly it doesn’t have 110x more
performance over the M2 Ultra, so what is going on here?  
---|---|---  
| ![](s.gif)| [](vote?id=37972064&how=up&goto=item%3Fid%3D37967126)| [kg](user?id=kg) [on Oct 22, 2023](item?id=37972064) | parent | next [[–]](javascript:void\(0\))  
NVIDIA's SMs are most comparable to the 'CUs' on AMD GPUs or cores on Apple
GPUs, generally speaking. The "cores" are subsets of the SM that perform
individual operations, IIRC.See this diagram from an nvidia blog post:
[https://developer-blogs.nvidia.com/wp-
content/uploads/2021/g...](https://developer-blogs.nvidia.com/wp-
content/uploads/2021/guc/raD52-V3yZtQ3WzOE0Cvzvt8icgGHKXPpN2PS_5MMyZLJrVxgMtLN4r2S2kp5jYI9zrA2e0Y8vAfpZia669pbIog2U9ZKdJmQ8oSBjof6gc4IrhmorT2Rr-
YopMlOf1aoU3tbn5Q.png)( [https://developer.nvidia.com/blog/nvidia-ampere-
architecture...](https://developer.nvidia.com/blog/nvidia-ampere-architecture-
in-depth/) )  
---|---|---  
| ![](s.gif)| [](vote?id=37972105&how=up&goto=item%3Fid%3D37967126)| [subharmonicon](user?id=subharmonicon) [on Oct 22, 2023](item?id=37972105) | parent | prev | next [[–]](javascript:void\(0\))  
NVIDIA is intentionally being obtuse and frankly dishonest calling what’s
effectively a vector lane a “core” and similarly using “thread” in “SIMT” to
mean the execution of one of those vector lanes.Yes, their architecture is
different from many in that they support a separate program counter per lane
(which is why they feel justified in calling this a “thread”), but ultimately
it’s the rate and throughput of ALUs that matter.  
---|---|---  
| ![](s.gif)| [](vote?id=37972189&how=up&goto=item%3Fid%3D37967126)| [freeone3000](user?id=freeone3000) [on Oct 22, 2023](item?id=37972189) | root | parent | next [[–]](javascript:void\(0\))  
It’s not even a seperate PC per lane, you only get that per block — lane level
execution goes to an execution mask lut per insn. Branchy code that’s not
branchy uniformly in the block executes a lot of noops.  
---|---|---  
| ![](s.gif)| [](vote?id=37972397&how=up&goto=item%3Fid%3D37967126)| [sakras](user?id=sakras) [on Oct 22, 2023](item?id=37972397) | root | parent | next [[–]](javascript:void\(0\))  
As of Volta, they have independent PCs with a warp optimizer that dynamically
groups threads with the same program counter, so branches aren’t nearly as bad
as they used to be.  
---|---|---  
| ![](s.gif)| [](vote?id=37972714&how=up&goto=item%3Fid%3D37967126)| [subharmonicon](user?id=subharmonicon) [on Oct 22, 2023](item?id=37972714) | root | parent | next [[–]](javascript:void\(0\))  
Can you cite a reference explaining this ability to re-form new warps from
existing threads?I ask because I’ve seen posts from NVIDIA support saying that
divergence is still very expensive and I’ve also seen benchmarks that force
divergence in each warp by evenly splitting the warp, and the benchmarks
result in 2x runtime when that happens vs. when the control-flow is
dynamically uniform.One thing to keep in mind is that even if you were to
dynamically reform-warps, there’s still a potential expense because you then
lose the advantage of doing things like accessing adjacent elements of data in
adjacent threads. You’re bound to now have more bank conflicts, fewer memory
accesses being coalesced, etc. Perhaps they do actually do this warp re-
formation, but that itself does have this additional cost.  
---|---|---  
| ![](s.gif)| [](vote?id=37988933&how=up&goto=item%3Fid%3D37967126)| [winwang](user?id=winwang) [on Oct 23, 2023](item?id=37988933) | root | parent | next [[–]](javascript:void\(0\))  
"Divergence is still very expensive" is quite compatible with "Divergence is
less expensive than before".Here's evidence (not proof) that Nvidia would
remove the hard limit of warp divergence (or perhaps more "precisely", *a warp
is always synchronous across its 32 threads with divergence"):
[https://developer.nvidia.com/blog/cooperative-
groups/](https://developer.nvidia.com/blog/cooperative-groups/)I don't think
it's misleading to talk about a "CUDA core" as a warp-wide processor, although
it seems that Nvidia doubles the number (at least for gaming GPUs), presumably
because of having both FP and INT pathways.  
---|---|---  
| ![](s.gif)| [](vote?id=37993446&how=up&goto=item%3Fid%3D37967126)| [subharmonicon](user?id=subharmonicon) [on Oct 24, 2023](item?id=37993446) | root | parent | next [[–]](javascript:void\(0\))  
Their “CUDA core” is not warp-wide, it’s a single lane.If you’re talking about
FP32 rates, they double it because of FMA (floating-point multiply-
accumulate). Everyone does that.  
---|---|---  
| ![](s.gif)| [](vote?id=37995482&how=up&goto=item%3Fid%3D37967126)| [freeone3000](user?id=freeone3000) [on Oct 24, 2023](item?id=37995482) | root | parent | prev | next [[–]](javascript:void\(0\))  
the SIMT section there is pretty telling — you can do it, if you explicitly
account for it, and are willing to leave other threads in the dust potentially
forever. It’s not _quite_ the same thing as JMP and only seems to account for
the data dependency case and not the if/else non-stream case.But I stand
corrected — Volta and up have multiple PCs per warp.  
---|---|---  
| ![](s.gif)| [](vote?id=37972340&how=up&goto=item%3Fid%3D37967126)| [mr_toad](user?id=mr_toad) [on Oct 22, 2023](item?id=37972340) | parent | prev | next [[–]](javascript:void\(0\))  
For one thing you can use the H100 to heat a room - it uses more than 10x the
power of an M2 Ultra.  
---|---|---  
| ![](s.gif)| [](vote?id=37989008&how=up&goto=item%3Fid%3D37967126)| [winwang](user?id=winwang) [on Oct 23, 2023](item?id=37989008) | root | parent | next [[–]](javascript:void\(0\))  
Consider AMD Epyc 7742 vs an A100 -- 225W vs 400W (according to some TDP
numbers). That's 1.8x-2.0x increase in energy, but something like 10x-100x
more integer operations per second (depending on size of integers, depending
on if you count the tensor cores or not).  
---|---|---  
| ![](s.gif)| [](vote?id=37968681&how=up&goto=item%3Fid%3D37967126)| [mannyv](user?id=mannyv) [on Oct 21, 2023](item?id=37968681) | prev | next [[–]](javascript:void\(0\))  
Now I understand why ML uses floats for precision. It wasn't a choice, it was
because graphics code uses them.Another piece in the "why is ML so
inefficient" puzzle!I wonder what that memory copying overhead is IRL. If it's
like normal stuff it'll be brutal. I mean, they offload tcp processing into
hardware to avoid that. This is way more data, though it is done in bigger
chunks.  
---|---|---  
| ![](s.gif)| [](vote?id=37968870&how=up&goto=item%3Fid%3D37967126)| [choppaface](user?id=choppaface) [on Oct 21, 2023](item?id=37968870) | parent | next [[–]](javascript:void\(0\))  
For a lot of larger modern networks the GPU compute time in computing
gradients and doing the backwards pass is so slow that copying float data over
the pcie bus is no bottleneck. I.e. copying a minibatch of float images is
still plenty fast because the gradients / SGD iteration is so slow and
requires so much compute (even with mixed precision).For shallower networks,
there can be an advantage to copying just the original compressed data to GPU
memory and then doing decompression etc there. But modern GPUs haven’t adopted
pcie 5 yet because the raw compute is more important.Lastly tensor cores have
had a big impact, depending on the network they can be fast enough to be very
under-utilized.  
---|---|---  
| ![](s.gif)| [](vote?id=37969694&how=up&goto=item%3Fid%3D37967126)| [touisteur](user?id=touisteur) [on Oct 21, 2023](item?id=37969694) | root | parent | next [[–]](javascript:void\(0\))  
I would say that some one modern GPU has adopted PCIe 5.0, the NVIDIA H100 -
if you want more (FP32) 'compute' (and no HBM...) in one GPU your sourceable
choice is the L40 which didn't get PCIe 5.0. This feels like another
market/product segmentation (that and L40 didn't get nvlink).  
---|---|---  
| ![](s.gif)| [](vote?id=37969960&how=up&goto=item%3Fid%3D37967126)| [oivey](user?id=oivey) [on Oct 21, 2023](item?id=37969960) | parent | prev | next [[–]](javascript:void\(0\))  
I don’t think the choice of using floating point numbers is particularly
inefficient. If frameworks were fixed point by default it would be tricky to
get the dynamic ranges right all the way through a network. The math in the
training assumes the numbers are continuous, too.  
---|---|---  
| ![](s.gif)| [](vote?id=37976902&how=up&goto=item%3Fid%3D37967126)| [mannyv](user?id=mannyv) [on Oct 22, 2023](item?id=37976902) | parent | prev | next [[–]](javascript:void\(0\))  
Floats are bigger, and math with them is more difficult.But really, I wondered
why the cpu-bound LLMs do quantization, which from what I understand is the
process of reducing the precision of the weights to use less memory.Does the
lack of precision make a difference? It's unclear. If that's the case, then
why use FP at all? If precision doesn't matter, then the extra precision is
just making the process use more resources for no real reason. And likely
orders of magnitude more resources than required.I mean, this field wasn't
started by people who understood performance. They used tools and built
something...but there's no 'why.' This is what the tools did, so they did
that.Here's why that might be important: on a normal CPU, accessing data one
way can be orders of magnitude faster than another way...but you have to be
aware. Would you like to reduce your LLM costs by orders of magnitude?  
---|---|---  
| ![](s.gif)| [](vote?id=37973066&how=up&goto=item%3Fid%3D37967126)| [Dylan16807](user?id=Dylan16807) [on Oct 22, 2023](item?id=37973066) | parent | prev | next [[–]](javascript:void\(0\))  
What's inefficient about floats? ML seems to get a big benefit out of having
access to multiple/many orders of magnitude.  
---|---|---  
| ![](s.gif)| [](vote?id=37970776&how=up&goto=item%3Fid%3D37967126)| [diimdeep](user?id=diimdeep) [on Oct 21, 2023](item?id=37970776) | prev | next [[–]](javascript:void\(0\))  
Also check out this talk and slides from few years ago about CPU and GPU
nitpicksAlexander Titov — Know your hardware: CPU memory hierarchy
[https://youtu.be/QOJ2hsop6hM](https://youtu.be/QOJ2hsop6hM)[https://github.com/alexander-
titov/public/blob/master/confer...](https://github.com/alexander-
titov/public/blob/master/conferences/cpp-meetup-march-2019/)Know Your Hardware
- CPU Memory Hierarchy -- Alexander Titov -- C%2B%2B Moscow Meetup March
2019.pdf[https://github.com/alexander-
titov/public/blob/master/confer...](https://github.com/alexander-
titov/public/blob/master/conferences/corehard-2019/)GPGPU - what it is and why
you should care -- Alexander Titov -- CoreHard 2019.pdf  
---|---|---  
| ![](s.gif)| [](vote?id=37967768&how=up&goto=item%3Fid%3D37967126)| [Jeff_Brown](user?id=Jeff_Brown) [on Oct 21, 2023](item?id=37967768) | prev | next [[–]](javascript:void\(0\))  
Not _every_ developer.I'm not trying to be snarky. I think there's an
unhelpful compunction to want to know everything about everything among STEM
types like programmers (of which I am one). Specialization is fundamental to
the success, not just of whole economies, but of the individuals in them. It
can feel like a paintful sacrifice to admit that you'll never (have time to)
learn, say, the entire Python language specification, or how type inference
works, or any number of other things someone might tell you is critical
knowledge. But it's often liberating, and more often than that,
mandatory.(Maybe I was trying to be a _little_ snarky initially, but I'm not
any more.)  
---|---|---  
| ![](s.gif)| [](vote?id=37967985&how=up&goto=item%3Fid%3D37967126)| [yodsanklai](user?id=yodsanklai) [on Oct 21, 2023](item?id=37967985) | parent | next [[–]](javascript:void\(0\))  
> It can feel like a paintful sacrifice to admit that you'll never (have time
> to) learnAnd even if you do have time, you'll probably forget most of it if
> you don't make use of it in your daily job. Also if you do want to learn
> about a new topic, it'll take commitment. I remember going through an MIT OS
> project, it took me something like 50 hours of hours to complete the
> project. Pretty much impossible when you have a full time job (I didn't at
> the time). And despite that, I still consider myself a newbie in OS
> development.That being said, a little extra knowledge can come handy and
> make a difference in an interview for instance, or reduce ramp-up time when
> changing teams.This is also what school is for. Give you full time and a
> structured program to pick the fundamentals. There's only so much you can
> learn once you have a demanding job. It's actually pretty sad we don't get
> to go back to school in the middle of our career.Edit: still an interesting
> article ;)  
---|---|---  
| ![](s.gif)| [](vote?id=37968441&how=up&goto=item%3Fid%3D37967126)| [owl57](user?id=owl57) [on Oct 21, 2023](item?id=37968441) | root | parent | next [[–]](javascript:void\(0\))  
> I remember going through an MIT OS project, it took me something like 50
> hours of hours to complete the project. Pretty much impossible when you have
> a full time job (I didn't at the time). And despite that, I still consider
> myself a newbie in OS development.I took an OS course loosely based on MIT
> one, and of course wouldn't consider myself an experienced OS developer as
> well, but I think the residual knowledge is sometimes really helpful when
> debugging bad application performance at work.  
---|---|---  
| ![](s.gif)| [](vote?id=37968191&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37968191) | root | parent | prev | next [[–]](javascript:void\(0\))  
Thank you :)  
---|---|---  
| ![](s.gif)| [](vote?id=37968119&how=up&goto=item%3Fid%3D37967126)| [loeg](user?id=loeg) [on Oct 21, 2023](item?id=37968119) | parent | prev | next [[–]](javascript:void\(0\))  
At this point, I think the running shtick / inside joke of "Every Developer
Should Know ..." headlines is that of course every developer doesn't need to
know the contents of the article that follows.  
---|---|---  
| ![](s.gif)| [](vote?id=37968433&how=up&goto=item%3Fid%3D37967126)| [wongarsu](user?id=wongarsu) [on Oct 21, 2023](item?id=37968433) | root | parent | next [[–]](javascript:void\(0\))  
> of course every developer doesn't need to know the contents of the article
> that follows.Things every developer should know about English, part 1: why
> word order matters in negation /sObviously you meant "not every developer
> needs to know" instead of "every developer doesn't need to know", but I see
> this switch so often lately that I'm beginning to wonder if it's a dialect
> thing (similar to double negative implying a positive to some and an
> emphasis of the negative to others)  
---|---|---  
| ![](s.gif)| [](vote?id=37969029&how=up&goto=item%3Fid%3D37967126)| [a1369209993](user?id=a1369209993) [on Oct 21, 2023](item?id=37969029) | root | parent | next [[–]](javascript:void\(0\))  
Actually, that seems to be a legitimate precedence ambiguity. The probably
more common way to parse/interpret it is:> [Foreach developer D, D] needs to
know this.> [Foreach developer D, D] doesn't need to know this. (No
developers.)But you could also have:> [The logical conjuction of all
developers[0]] needs to know this.> [The logical conjuction of all developers]
doesn't need to know this. (Not all developers.)The former convention is
clearly better unless I've missed something rather significant, but inherently
broken features in a number of programming languages (eg perl 6 'junctive'
operators) suggest the latter is well-established as a thing that exists.0:
ie, a linguistic fiction that has only those properties / needs only those
things that are common to every developer.  
---|---|---  
| ![](s.gif)| [](vote?id=37968398&how=up&goto=item%3Fid%3D37967126)| [bachmeier](user?id=bachmeier) [on Oct 21, 2023](item?id=37968398) | root | parent | prev | next [[–]](javascript:void\(0\))  
Not true. Anyone experienced in programming discussions knows that "software
development" overlaps exactly with the programming done by the commenter, and
everything else is solving toy problems with tools that don't scale.  
---|---|---  
| ![](s.gif)| [](vote?id=37969321&how=up&goto=item%3Fid%3D37967126)| [arp242](user?id=arp242) [on Oct 21, 2023](item?id=37969321) | root | parent | prev | next [[–]](javascript:void\(0\))  
I'm okay if "every" just means "most"; for example Spolsky's old "what every
developers needs to know about Unicode" (which is the origin of this, AFAIK)
is fine because most (but not _all_) developers will need to deal with text
sooner or later.But in this case it doesn't even mean that: all of this
applies to a substantial minority of programmers, but definitely a minority.  
---|---|---  
| ![](s.gif)| [](vote?id=37971660&how=up&goto=item%3Fid%3D37967126)| [LouisSayers](user?id=LouisSayers) [on Oct 22, 2023](item?id=37971660) | root | parent | prev | next [[–]](javascript:void\(0\))  
There are at most 10 things every developer should know.The first being number
base systems.  
---|---|---  
| ![](s.gif)| [](vote?id=37967962&how=up&goto=item%3Fid%3D37967126)| [cratermoon](user?id=cratermoon) [on Oct 21, 2023](item?id=37967962) | parent | prev | next [[–]](javascript:void\(0\))  
I dunno. The section "Latency Tolerance, High Throughput and Little’s Law" has
many applications in programming. Ever need to scale your cache, or size a
connection pool? Little's Law.  
---|---|---  
| ![](s.gif)| [](vote?id=37968348&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37968348) | root | parent | next [[–]](javascript:void\(0\))  
Thank you for reading! :)  
---|---|---  
| ![](s.gif)| [](vote?id=37968439&how=up&goto=item%3Fid%3D37967126)| [cratermoon](user?id=cratermoon) [on Oct 21, 2023](item?id=37968439) | root | parent | next [[–]](javascript:void\(0\))  
Thanks for writing this. I note you mention that GPUs are massively parallel,
and I think it would strengthen the article to add a paragraph or two
discussing what kinds of loads lend themselves to GPU computing. The sort of
"embarrassingly parallel" things like linear algebra vs inherently serial
example of numerical analysis.  
---|---|---  
| ![](s.gif)| [](vote?id=37968718&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37968718) | root | parent | next [[–]](javascript:void\(0\))  
Yes, that's a good feedback. Few other people also mentioned this. I was
trying to save space, to spend time more on the "how things work" part. But I
see your point that some motivation behind parallelization would make it a
more interesting read.  
---|---|---  
| ![](s.gif)| [](vote?id=37969099&how=up&goto=item%3Fid%3D37967126)| [Agingcoder](user?id=Agingcoder) [on Oct 21, 2023](item?id=37969099) | parent | prev | next [[–]](javascript:void\(0\))  
I’d say very few actually ( and I say this from the perspective of someone who
used to work in hpc ). If they need to know about hw, most devs need to know
about their primary platform, ie cpu. Gpus for general purpose computing ( I’m
deliberately excluding games here, and even then it’s not obvious ) and
programmed by people who don’t write ml/hpc libraries are far from
ubiquitous.Yes, you want to know as much as possible ( helps debugging/zooming
in on issues since you don’t need to introduce an outsider to your problem,
helps avoid errors), yes you need to specialize somewhere, no you can’t know
everything and often don’t need to  
---|---|---  
| ![](s.gif)| [](vote?id=37967879&how=up&goto=item%3Fid%3D37967126)| [nabla9](user?id=nabla9) [on Oct 21, 2023](item?id=37967879) | parent | prev | next [[–]](javascript:void\(0\))  
This is just minimum for those don't need to know details.Even general
knowledge has depth. Even if you are generalist, or specialist in different
area you should deepen your knowledge at every area gradually.  
---|---|---  
| ![](s.gif)| [](vote?id=37968339&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37968339) | root | parent | next [[–]](javascript:void\(0\))  
True. This is probably what first few lectures of a first course on GPU
computing would cover. The nitty gritty of how to write parallel algorithms
for maximum throughput on the GPU is where things become too specific. :)  
---|---|---  
| ![](s.gif)| [](vote?id=37968003&how=up&goto=item%3Fid%3D37967126)| [pjmlp](user?id=pjmlp) [on Oct 21, 2023](item?id=37968003) | parent | prev | next [[–]](javascript:void\(0\))  
Indeed, one thing that most seniors learn is humility and being able to say I
don't know, without caring about consequences.  
---|---|---  
| ![](s.gif)| [](vote?id=37968396&how=up&goto=item%3Fid%3D37967126)| [bobwaycott](user?id=bobwaycott) [on Oct 21, 2023](item?id=37968396) | root | parent | next [[–]](javascript:void\(0\))  
An invaluable life skill, as well.  
---|---|---  
| ![](s.gif)| [](vote?id=37968747&how=up&goto=item%3Fid%3D37967126)| [crabbone](user?id=crabbone) [on Oct 21, 2023](item?id=37968747) | parent | prev | next [[–]](javascript:void\(0\))  
You are interpreting the title literally, while all this article is trying to
do is to give an introduction to anyone who wants to get into GPU
programming.Now, about _every_ developer. Ideally, developers should know
something, in general, about all fields related to programming. Similar to how
in medicine you need to learn about different branches of medicine, even
though you'll specialize in one, and so it is in mathematics, physics and so
on.Presently, the demand for quality professionals in programming is _very_
low. There aren't any good testing or certification programs that can tell a
good programmer from a bad one. The industry is generally happy with
"specialists" who perhaps only know to do one thing, somewhat. So, _presently_
you don't need to know anything about GPU or any other field that's not
directly related to your job description.\----Now, about the article itself.
While it gives a lot of valuable factual information, it's missing the forest
for the trees. It's very dedicated to how CUDA works or some other particular
aspects of NVidia's GPUs. The part that's missing is the part that could make
it, potentially, a candidate for the kind of introduction to GPU programming
that would make it worth reading to expand your general understanding of how
computers work.If you ever paid attention to how encyclopedic articles are
written: the structure of a definition given by encyclopedia often has two
components. First puts the object of the definition into the more general
category, second explains how the object of the definition is different from
other elements of the category. What the GPU article is missing is the first
component: putting GPU programming into the more general category. This, in
practical terms, means that questions like "is DPU programming anything like
GPU programming?" or "can `smart' SSDs (with FPGAs) be treated similar to
GPUs?" unanswered.  
---|---|---  
| ![](s.gif)| [](vote?id=37968197&how=up&goto=item%3Fid%3D37967126)| [cj](user?id=cj) [on Oct 21, 2023](item?id=37968197) | parent | prev | next [[–]](javascript:void\(0\))  
One thing I find interesting about the software industry is our lack of
descriptive job titles.At big companies you have SWE L1, L2, L3, senior,
staff, principal, etc. You also have SRE and maybe some devops or architect
roles.Smaller companies you have lots of people generic “engineer” titles or
“full stack engineers”, etc.Why don’t we encode people’s specialties in their
titles if most engineers are working on narrow sections of software?E.g.
“React & Node Developer” instead of “Full stack engineer” … etcI suppose the
easiest rationale is generic titles allow for easier mobility between
disciplines.  
---|---|---  
| ![](s.gif)| [](vote?id=37969034&how=up&goto=item%3Fid%3D37967126)| [nativeit](user?id=nativeit) [on Oct 21, 2023](item?id=37969034) | parent | prev | next [[–]](javascript:void\(0\))  
I can appreciate what you’re getting at in mourning the absence of greater
opportunities for in-depth learning, but I personally value and appreciate the
learning process such that I am overwhelmed by gratitude that I will likely
never be without something to hold my interest. I have a deep understanding of
the things I use in my daily work, but I think holding a breadth of knowledge
is also useful in that you have a higher appreciation for what other
specialists know and do, and in the event you need something novel, you may
have a head start in getting to the knowledge you need at the time. I view it
as unreservedly positive to audit many subjects even if you cannot engage with
them further.  
---|---|---  
| ![](s.gif)| [](vote?id=37967802&how=up&goto=item%3Fid%3D37967126)| [Jiro](user?id=Jiro) [on Oct 21, 2023](item?id=37967802) | parent | prev | next [[–]](javascript:void\(0\))  
Over-specialization is hard on your ability to find another job if you lose
your current one.  
---|---|---  
| ![](s.gif)| [](vote?id=37968024&how=up&goto=item%3Fid%3D37967126)| [andrewSC](user?id=andrewSC) [on Oct 21, 2023](item?id=37968024) | root | parent | next [[–]](javascript:void\(0\))  
And so it’s a balance :^) I personally take the approach of specializing in
what I believe to be my natural talents (i.e. seemingly able to pick up X much
easier than whoever) while just being generally aware of new technologies or
other spaces/sectors. Also tinkering and/or having a general interest in tech
helps lol.. IME doing this has helped me pivot into a new tech or other areas
where I may not be specialized in, but may need to eventually be for a new
role. Also worth mentioning is taking a pragmatic approach to problem solving
in general.. I’ve personally found that if you’re able to demonstrate solid
reasoning and/or problem solving, generally learning a new lang or
specializing in something different than what you’re used to, isn’t too too
bad. I’m not really sure how specialists outside of tech/in other sectors can
transition into other roles “easily” though… hm.Edit: I wanted to mention that
IME in STEM, most? More often than not? are goal oriented… It is _completely_
okay to not have any “working” thing at the end of your tinkering/learning…
The journey into that “thing” can be a learning experience in and of itself.
I’ve often started to learn things but after a certain point have told myself
“I’m gonna stop here and that’s okay. I don’t need to have a solid
understanding of this, at this time”. YMMV…  
---|---|---  
| ![](s.gif)| [](vote?id=37967973&how=up&goto=item%3Fid%3D37967126)| [Jeff_Brown](user?id=Jeff_Brown) [on Oct 21, 2023](item?id=37967973) | root | parent | prev | next [[–]](javascript:void\(0\))  
Completely true. The analogy to hydration holds, I think -- too much and too
little can both be problematic. But I see seem to run into much more under-
specialization than over-specialization. More than 90% of the wildest
successes I know went really deep on something pretty narrow.  
---|---|---  
| ![](s.gif)| [](vote?id=37968154&how=up&goto=item%3Fid%3D37967126)| [HPsquared](user?id=HPsquared) [on Oct 21, 2023](item?id=37968154) | root | parent | next [[–]](javascript:void\(0\))  
Specialization is like putting everything on one number in roulette. It's
great if you win (i.e. your specialty is in demand), but you're more likely to
lose everything you invested.  
---|---|---  
| ![](s.gif)| [](vote?id=37978001&how=up&goto=item%3Fid%3D37967126)| [Jeff_Brown](user?id=Jeff_Brown) [on Oct 22, 2023](item?id=37978001) | root | parent | next [[–]](javascript:void\(0\))  
It _is_ a risk, but not as bad as you suggest, because (1) in work you can get
an incremental sense of what is worth specializing in, and (2) there's always
some degree to which skills are transferrable and experience is impressive
even to someone who doesn't need you to do what you did again.  
---|---|---  
| ![](s.gif)| [](vote?id=37969914&how=up&goto=item%3Fid%3D37967126)| [nologic01](user?id=nologic01) [on Oct 21, 2023](item?id=37969914) | prev | next [[–]](javascript:void\(0\))  
It is anybody's guess what the future will bring, but on past form GPU
programming will remain a niche for specific highly-tuned (HPC) applications
and mere mortals can focus on somewhat easier multi-core CPU programming
instead.The main reason GPU gets _so much_ attention these days is that CPU
manufacturers (Intel in particular) simply cannot get their act together.
Intel had promised significant breakthroughs with Xeon Phi like a decade
ago.In the meantime people have invented more and more applications that need
significant computational power. But it will eventually get there. E.g., AMD'
latest epyc features 96 cores. Importantly, that computational power is
available in principle with simpler / more familiar programming models.  
---|---|---  
| ![](s.gif)| [](vote?id=37970305&how=up&goto=item%3Fid%3D37967126)| [qwertox](user?id=qwertox) [on Oct 21, 2023](item?id=37970305) | prev | next [[–]](javascript:void\(0\))  
Let's assume I have an array of 10.000 lat/lng-pairs. I want to compute the
length of the track. I duplicate the array and remove the first item in the
duplicated array, append the last entry of the original array to the duplicate
in order for them to be equal in length.Then I use a vectorized haversine
algorithm on these arrays to obtain a third one with the distances between
each "row" of the two arrays.With NumPy this is fast, but I guess that a GPU
could also perform this and likely do it much faster. Would it be worth it if
one has to consider that the data needs to be moved to the GPU and the result
be retrieved?  
---|---|---  
| ![](s.gif)| [](vote?id=37970441&how=up&goto=item%3Fid%3D37967126)| [kylebarron](user?id=kylebarron) [on Oct 21, 2023](item?id=37970441) | parent | next [[–]](javascript:void\(0\))  
10,000 coordinates are certainly not enough to see the difference, but at some
scale this would be faster on the GPU.This is implemented in an nvidia
geospatial library call cuspatial:
[https://docs.rapids.ai/api/cuspatial/legacy/api_docs/spatial...](https://docs.rapids.ai/api/cuspatial/legacy/api_docs/spatial/#cuspatial.haversine_distance)  
---|---|---  
| ![](s.gif)| [](vote?id=37970364&how=up&goto=item%3Fid%3D37967126)| [rational_indian](user?id=rational_indian) [on Oct 21, 2023](item?id=37970364) | parent | prev | next [[–]](javascript:void\(0\))  
You need to try it and see if it is any faster. NVIDIA has a drop-in
replacement for numpy:
[https://developer.nvidia.com/cunumeric](https://developer.nvidia.com/cunumeric).  
---|---|---  
| ![](s.gif)| [](vote?id=37970396&how=up&goto=item%3Fid%3D37967126)| [dataflow](user?id=dataflow) [on Oct 21, 2023](item?id=37970396) | parent | prev | next [[–]](javascript:void\(0\))  
Not the answer to your question, but:> I duplicate the array and remove the
first item in the duplicated array, append the last entry of the original
array to the duplicate in order for them to be equal in length.I assume/hope
this is only what you're doing logically, not physically?Otherwise you might
as well just compute the length using n - 1 points from the existing array,
then do the remaining portion manually and add it to the existing sum. That
would avoid the copying of the whole array.  
---|---|---  
| ![](s.gif)| [](vote?id=37970390&how=up&goto=item%3Fid%3D37967126)| [tlb](user?id=tlb) [on Oct 21, 2023](item?id=37970390) | parent | prev | next [[–]](javascript:void\(0\))  
Probably not. The computation is only a few trig instructions per array
element, so most of the time is moving data on either CPU or GPU.  
---|---|---  
| ![](s.gif)| [](vote?id=37970388&how=up&goto=item%3Fid%3D37967126)| [dist-epoch](user?id=dist-epoch) [on Oct 21, 2023](item?id=37970388) | parent | prev | next [[–]](javascript:void\(0\))  
> Would it be worth it if one has to consider that the data needs to be moved
> to the GPU and the result be retrievedDepends on your batch size. If the
> computation on the CPU is less than lets say 200 ms it's probably not worth
> it.Also consider that integrated GPUs don't have separate memory, I'm not
> sure, but they might not have a high cost of moving data to memory.  
---|---|---  
| ![](s.gif)| [](vote?id=37969750&how=up&goto=item%3Fid%3D37967126)| [jokoon](user?id=jokoon) [on Oct 21, 2023](item?id=37969750) | prev | next [[–]](javascript:void\(0\))  
I wish it was easier to program a GPU...I've already refrained myself to learn
vulkan because it scares me, but similarly, opengl and cuda are a bit
mysterious to me, and I don't really know how I could take advantage of it,
since most computing tasks cannot be made parallel.I've read there are data
structures that are somehow able to take advantage of a GPU as an alternative
to the CPU (for example a database running on a GPU), but it seems a very new
domain, and I don't have the skill to explore it.  
---|---|---  
| ![](s.gif)| [](vote?id=37972148&how=up&goto=item%3Fid%3D37967126)| [HalfCrimp](user?id=HalfCrimp) [on Oct 22, 2023](item?id=37972148) | parent | next [[–]](javascript:void\(0\))  
If you are comfortable with C++ already then look at Thrust. It's nvidia's
analogue to the standard library arrived at GPU computing.Writing and
launching raw cuda kernels is too low level for me, but writing with Thrust
makes it feel pretty similar to writing regular C++ code. You still need to
deal with moving data from host to device and back, but that's as simple as
assigning a `thrust::device_vector` to a `thrust::host_vector`  
---|---|---  
| ![](s.gif)| [](vote?id=37972621&how=up&goto=item%3Fid%3D37967126)| [rnrn](user?id=rnrn) [on Oct 22, 2023](item?id=37972621) | root | parent | next [[–]](javascript:void\(0\))  
or look at using standard C++ with an implementation that uses the GPU:
[https://docs.nvidia.com/hpc-sdk/compilers/c++-parallel-
algor...](https://docs.nvidia.com/hpc-sdk/compilers/c++-parallel-
algorithms/index.html)  
---|---|---  
| ![](s.gif)| [](vote?id=37971732&how=up&goto=item%3Fid%3D37967126)| [rakkhi](user?id=rakkhi) [on Oct 22, 2023](item?id=37971732) | prev | next [[–]](javascript:void\(0\))  
Imagine with NVIDIA banned in china, how well the Chinese local companies will
do in GPU's for AI:
[https://x.com/BeijingDai/status/1715861773495279743?s=20](https://x.com/BeijingDai/status/1715861773495279743?s=20)  
---|---|---  
| ![](s.gif)| [](vote?id=37972086&how=up&goto=item%3Fid%3D37967126)| [kg](user?id=kg) [on Oct 22, 2023](item?id=37972086) | parent | next [[–]](javascript:void\(0\))  
It's going to take them a while to catch up to CUDA, though. Even with stolen
IP it's going to be tough to make 1:1 drop-in replacements. The amount of
existing investment into AMD and NVIDIA architectures is huge, as evidenced by
how bad the Moore Threads GPUs are - it simply isn't easy to enter the market
as a serious competitor. Even Intel is struggling.  
---|---|---  
| ![](s.gif)| [](vote?id=37971704&how=up&goto=item%3Fid%3D37967126)| [kdwikzncba](user?id=kdwikzncba) [on Oct 22, 2023](item?id=37971704) | prev | next [[–]](javascript:void\(0\))  
> We can understand this with the help of Little’s law from queuing theory. It
> states that the average number of requests in the system (Qd for queue
> depth) is equal to the average arrival rate of requests (throughput T)
> multiplied by the average amount of time to serve a request (latency
> L).First off, this is obviously false. If you can serve 9req/s and you're
> getting 10req/s the size of the queue depth is growing at a rate of 1req/s.
> It's not stationary.Second, what's the connection between this and gpus?
> What's the queue? What's the queue depth? What are the requests?Seems to me
> that the article focuses more on being smart than actually learning.  
---|---|---  
| ![](s.gif)| [](vote?id=37971746&how=up&goto=item%3Fid%3D37967126)| [minitoar](user?id=minitoar) [on Oct 22, 2023](item?id=37971746) | parent | next [[–]](javascript:void\(0\))  
The scenario is that you’re calculating Qd given a static average latency.
Absent that, this formula doesn’t give you a way to compute Qd. What is the
average amount of time to service a request in a system where the queue depth
is growing without bound?  
---|---|---  
| ![](s.gif)| [](vote?id=37971784&how=up&goto=item%3Fid%3D37967126)| [ssivark](user?id=ssivark) [on Oct 22, 2023](item?id=37971784) | parent | prev | next [[–]](javascript:void\(0\))  
> First off, this is obviously false. If you can serve 9req/s and you're
> getting 10req/s the size of the queue depth is growing at a rate of 1req/s.
> It's not stationary.I haven’t formally studied any queuing theory, but I
> think:1\. The rule assumes you have enough processing power to service the
> average load (otherwise it fails catastrophically like you mentioned)2\. The
> rule is trying to model the _fluctuations_ in the pending load (which might
> determine wait time or whatever else).  
---|---|---  
| ![](s.gif)| [](vote?id=37970158&how=up&goto=item%3Fid%3D37967126)| [osigurdson](user?id=osigurdson) [on Oct 21, 2023](item?id=37970158) | prev | next [[–]](javascript:void\(0\))  
>> Most programmers have an intimate understanding of CPUsI'd say the mental
model for most programmers is: lines of text, in their language of choice,
zipping by really fast.  
---|---|---  
| ![](s.gif)| [](vote?id=37970992&how=up&goto=item%3Fid%3D37967126)| [jacquesm](user?id=jacquesm) [on Oct 21, 2023](item?id=37970992) | parent | next [[–]](javascript:void\(0\))  
By the time you're looking at using GPUs my assumption would be that you've
left that particular mental model behind long ago.  
---|---|---  
| ![](s.gif)| [](vote?id=37970256&how=up&goto=item%3Fid%3D37967126)| [quickthrower2](user?id=quickthrower2) [on Oct 21, 2023](item?id=37970256) | parent | prev | next [[–]](javascript:void\(0\))  
Like an interpreted language I suppose  
---|---|---  
| ![](s.gif)| [](vote?id=37971401&how=up&goto=item%3Fid%3D37967126)| [RevEng](user?id=RevEng) [on Oct 21, 2023](item?id=37971401) | prev | next [[–]](javascript:void\(0\))  
This is one of the better explanations I've seen of how GPU programming works.
I'll be using this for my mentees in the future. Well done!  
---|---|---  
| ![](s.gif)| [](vote?id=37970430&how=up&goto=item%3Fid%3D37967126)| [fatih-erikli](user?id=fatih-erikli) [on Oct 21, 2023](item?id=37970430) | prev | next [[–]](javascript:void\(0\))  
I think GPU computing should not be done in application layer. It's way too
low-level.  
---|---|---  
| ![](s.gif)| [](vote?id=37971024&how=up&goto=item%3Fid%3D37967126)| [jacquesm](user?id=jacquesm) [on Oct 21, 2023](item?id=37971024) | parent | next [[–]](javascript:void\(0\))  
That's the only layer where it makes sense because that's where you know what
it is that you are trying to achieve. The overhead in GPU programming is such
that if you make one small assumption that doesn't hold true in practice you
may end up sinking your performance in a terrible way. So you need a lot of
control over where and how things are laid out. For more generic stuff there
are libraries, but those too run at the behest of your application. As this
technology matures you'll see more and more abstraction and automation of the
parts that squeeze out the most performance. But for now that's where you can
make the biggest gains, just like any other kind of special purpose co-
processor.  
---|---|---  
| ![](s.gif)| [](vote?id=38005954&how=up&goto=item%3Fid%3D37967126)| [fatih-erikli](user?id=fatih-erikli) [on Oct 24, 2023](item?id=38005954) | root | parent | next [[–]](javascript:void\(0\))  
Makes sense.  
---|---|---  
| ![](s.gif)| [](vote?id=37972248&how=up&goto=item%3Fid%3D37967126)| [markhahn](user?id=markhahn) [on Oct 22, 2023](item?id=37972248) | prev | next [[–]](javascript:void\(0\))  
it's not just nvidia-specific, but nvidia-biased. the misuse of "core",
pretending that CPUs are backwards, etc.every developer should know about more
than nvidia's spin.  
---|---|---  
| ![](s.gif)| [](vote?id=37970319&how=up&goto=item%3Fid%3D37967126)| [godelski](user?id=godelski) [on Oct 21, 2023](item?id=37970319) | prev | next [[–]](javascript:void\(0\))  
I thought I'd share something with my experience with HPC that applies to many
areas, especially in the rise of GPUs.The main bottleneck isn't compute, it is
memory. If you go to talks you're gonna see lots of figures like this one[0]
(typically also showing disk speeds, which are crazy small).Compute is
increasing so fast that at this point we finish our operations long faster
than it takes to save those simulations or even create the visualizations and
put on disk. There's a lot of research going into this, with a lot of things
like in situ computing (asynchronous operations, often pushing to a different
machine, but needing many things like flash buffers. See ADIOS[1] as an
example software).What I'm getting at here is that we're at a point where we
have to think about that IO bottleneck, even for non-high performance systems.
I work in ML now, which we typically think of as compute bound, but being in
the generative space there are still many things where the IO bottlenecks.
This can be loading batches into memory, writing results to disk, or
communication between distributed processes. It's one beg reason we typically
want to maximize memory usage (large batches).There's a lot of low hanging
fruit in these areas that aren't going to be generally publishable works but
are going to have lots of high impact. Just look at things like LLaMA CPP[2],
where in the process they've really decreased the compute time and memory
load. There's also projects like TinyLLaMa[3] who are exploring training a 1B
model and doing so on limited compute, and are getting pretty good results.
But I'll tell you from personal experience, small models and limited compute
experience doesn't make for good papers (my most cited work did this and has
never been published, gotten many rejections for not competing with models
100x it's size, but is also quite popular in the general scientific community
who work with limited compute). Wfiw, companies that are working on
applications do value these things, but it is also noise in the community
that's hard to parse. Idk how we can do better as a community to not get
trapped in these hype cycles, because real engineering has a lot of these
aspects too, and they should be (but aren't) really good areas for academics
to be working in. Scale isn't everything in research, and there's a lot of
different problems out there that are extremely important but many are blind
to.And one final comment, there's lots of code that is used over and over that
are not remotely optimized and can be >100x faster. Just gotta slow down and
write good code. The move fast and break things method is great for getting
moving but the debt compounds. It's just debt is less visible, but there's so
much money being wasted from writing bad code (and LLMs are only going to
amplify this. They were trained on bad code after all). And no, pytorch isn't
going to optimize everything for you automagically (no one can. Optimization
is often situationally dependent). You're still gonna need to understand the
distributed package and it is worth learning MPI.[0]
[https://drivenets.com/wp-content/uploads/2023/05/blog-
networ...](https://drivenets.com/wp-content/uploads/2023/05/blog-networking-
bottlenecks-part2-full-1536x803.png)[1]
[https://github.com/ornladios/ADIOS2](https://github.com/ornladios/ADIOS2)[2]
[https://github.com/ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp)[3]
[https://github.com/jzhang38/TinyLlama](https://github.com/jzhang38/TinyLlama)  
---|---|---  
| ![](s.gif)| [](vote?id=37971030&how=up&goto=item%3Fid%3D37967126)| [jacquesm](user?id=jacquesm) [on Oct 21, 2023](item?id=37971030) | parent | next [[–]](javascript:void\(0\))  
Agreed, the memory bottle-neck is the biggest restriction. But even there
there is quite a bit of progress. NV in particular is milking that for as much
and as long as they can though. I'd be happy with a _slower_ GPU able to
address far more memory.  
---|---|---  
| ![](s.gif)| [](vote?id=37970152&how=up&goto=item%3Fid%3D37967126)| [MrRolleyes](user?id=MrRolleyes) [on Oct 21, 2023](item?id=37970152) | prev | next [[–]](javascript:void\(0\))  
TL;DR most developers don't need to know any of this.  
---|---|---  
| ![](s.gif)| [](vote?id=37970682&how=up&goto=item%3Fid%3D37967126)| [fancyfredbot](user?id=fancyfredbot) [on Oct 21, 2023](item?id=37970682) | prev | next [[–]](javascript:void\(0\))  
This article is pretty good but, looking at comments so far, nobody seems to
have made the obvious/predictable point that it's terribly Nvidia specific.
That would be understandable perhaps a few years ago. But the era where there
was no reasonable alternative is over. Sycl is a good language which performs
well across multiple hardware vendors. Sapphire rapids is very good hardware.
AMD's MI300 looks amazing. Nvidia has run out of GPUs. It's finally time for
GPU development to stop meaning CUDA, but I guess it's going to take the world
a while to realise this.  
---|---|---  
| ![](s.gif)| [](vote?id=37970974&how=up&goto=item%3Fid%3D37967126)| [jacquesm](user?id=jacquesm) [on Oct 21, 2023](item?id=37970974) | parent | next [[–]](javascript:void\(0\))  
At this point the massive investment in software is what drives this, hardware
differences may no longer be dominant but the only way to unseat NV at this
point is drop in replacements and/or drop in replacement libraries. And that's
getting there. Which is good because GPUs are too expensive and have too
little memory, some competition might help move things along rather than to
give NV more time to milk their precious digital cows.  
---|---|---  
| ![](s.gif)| [](vote?id=37971585&how=up&goto=item%3Fid%3D37967126)| [tormeh](user?id=tormeh) [on Oct 21, 2023](item?id=37971585) | root | parent | next [[–]](javascript:void\(0\))  
I really wish the ML researchers would have stayed with Vulkan or OpenCL
instead of standardising on CUDA. Everyone must have known how it would end.  
---|---|---  
| ![](s.gif)| [](vote?id=37971881&how=up&goto=item%3Fid%3D37967126)| [jacquesm](user?id=jacquesm) [on Oct 22, 2023](item?id=37971881) | root | parent | next [[–]](javascript:void\(0\))  
Sometimes people just have a job to do rather than to play politics and in
this case doing it with OpenCL or Vulkan would have ceded the market for their
application to the competition due the difference in speed and money spent for
a given amount of compute. That's starting to change but the competition has
reacted much too late. NVidia figured out that software is almost as important
as the hardware early enough that betting on that with a sizeable dedicated
team gave them a tremendous lead. I've used CUDA and have _tried_ to use
OpenCL but the number of hurdles I had to jump through with OpenCL made it a
non-starter and that was before factoring in the cost. NV made it easy and
made it work right out of the box. Quite often the most visible constraint is
developer time and reducing developer friction is a great way to capture a
larger slice of the market as well as to actually grow that market.  
---|---|---  
| ![](s.gif)| [](vote?id=37972803&how=up&goto=item%3Fid%3D37967126)| [bartwr](user?id=bartwr) [on Oct 22, 2023](item?id=37972803) | root | parent | prev | next [[–]](javascript:void\(0\))  
You have clearly not programmed in any of those. :)OpenCL was almost unusable
due to how difficult it was to set up, plus limited support. Vulcan is
terribly ugly and verbose and provides no benefits for pure compute workloads.
Writing a "hello word" is a few thousands lines of code, debugging
impossible.Working with CUDA is pure pleasure - immediate setup, super easy
CPU/GPU interop and code sharing, all the modern (at the time!) C++ features,
super pleasant debugging with stepping, profilers, everything. :)I totally
wish others invested as much into tools as NVIDIA did - but they didn't and
made the whole experience miserable. :( If your velocity is 1/10 because of
terrible tooling, you need to expect some insane benefits to pick it.  
---|---|---  
| ![](s.gif)| [](vote?id=37972009&how=up&goto=item%3Fid%3D37967126)| [PeterisP](user?id=PeterisP) [on Oct 22, 2023](item?id=37972009) | root | parent | prev | next [[–]](javascript:void\(0\))  
If AMD really wished ML researchers to use their hardware, they could have put
in the effort to make OpenCL or Vulkan competitive with CUDA with respect to
ease of developing ML systems. nVidia did put in that software effort, AMD
didn't so now they both reap the consequences.  
---|---|---  
| ![](s.gif)| [](vote?id=37972181&how=up&goto=item%3Fid%3D37967126)| [tormeh](user?id=tormeh) [on Oct 22, 2023](item?id=37972181) | root | parent | next [[–]](javascript:void\(0\))  
No argument there. AMD really shat the bed. But if you go with a single
supplier, it’s pretty weird to make the pricing agreement “we’ll pay whatever
you charge”.  
---|---|---  
| ![](s.gif)| [](vote?id=37972661&how=up&goto=item%3Fid%3D37967126)| [nomel](user?id=nomel) [on Oct 22, 2023](item?id=37972661) | root | parent | prev | next [[–]](javascript:void\(0\))  
Related, I’m putting some money into AMD. They can only improve, at this
point.  
---|---|---  
| ![](s.gif)| [](vote?id=37971743&how=up&goto=item%3Fid%3D37967126)| [behnamoh](user?id=behnamoh) [on Oct 22, 2023](item?id=37971743) | root | parent | prev | next [[–]](javascript:void\(0\))  
Those ml researchers wanted to get hired…  
---|---|---  
| ![](s.gif)| [](vote?id=37972020&how=up&goto=item%3Fid%3D37967126)| [p1esk](user?id=p1esk) [on Oct 22, 2023](item?id=37972020) | root | parent | next [[–]](javascript:void\(0\))  
Those ML researchers (myself included) wanted to get the job done.  
---|---|---  
| ![](s.gif)| [](vote?id=37972254&how=up&goto=item%3Fid%3D37967126)| [markhahn](user?id=markhahn) [on Oct 22, 2023](item?id=37972254) | root | parent | prev | next [[–]](javascript:void\(0\))  
huh? don't ML researchers use pytorch and tensorflow?  
---|---|---  
| ![](s.gif)| [](vote?id=37972396&how=up&goto=item%3Fid%3D37967126)| [AmblingAvocado](user?id=AmblingAvocado) [on Oct 22, 2023](item?id=37972396) | root | parent | next [[–]](javascript:void\(0\))  
I’m guessing we’re talking about the pioneers here.  
---|---|---  
| ![](s.gif)| [](vote?id=37972590&how=up&goto=item%3Fid%3D37967126)| [rnrn](user?id=rnrn) [on Oct 22, 2023](item?id=37972590) | parent | prev | next [[–]](javascript:void\(0\))  
Sapphire Rapids is a CPU.AMD's primary focus for a GPU software ecosystem
these days seems to be implementing CUDA with s/cuda/hip  
---|---|---  
| ![](s.gif)| [](vote?id=37974143&how=up&goto=item%3Fid%3D37967126)| [fancyfredbot](user?id=fancyfredbot) [on Oct 22, 2023](item?id=37974143) | root | parent | next [[–]](javascript:void\(0\))  
Oops! Yes I meant Ponte Vecchio not Sapphire Rapids. It's now called "Intel
data centre GPU Max" which although it doesn't exactly roll of the tounge is
at least harder to confuse with a CPU!  
---|---|---  
| ![](s.gif)| [](vote?id=37968151&how=up&goto=item%3Fid%3D37967126)| [cebert](user?id=cebert) [on Oct 21, 2023](item?id=37968151) | prev | next [[–]](javascript:void\(0\))  
> Most programmers have an intimate understanding of CPUs and sequential
> programming because they grow up writing code for the CPUMaybe it’s just
> where I work, but I feel like even this isn’t true. A lot of the newer/young
> employees don’t even seem to have a lot of OS/system understanding. A lot of
> the higher-level languages abstract the immediate need of having any
> “intimate understanding” of CPUs.  
---|---|---  
| ![](s.gif)| [](vote?id=37968780&how=up&goto=item%3Fid%3D37967126)| [softfalcon](user?id=softfalcon) [on Oct 21, 2023](item?id=37968780) | parent | next [[–]](javascript:void\(0\))  
Yup, I was coming up under a senior at my work one day and he tried to very
incorrectly hand wave how a browser uses a GPU to accelerate draw calls.I had
done work in the C/C++ code modifying Chromium directly and went, “that’s not
how the browser talks to the OS to use the GPU for acceleration”. They
immediately tried to argue I was wrong and made some more nonsense up.This
person is a very competent coder, but we got into further discussions and it
was made very clear they had lived in a JavaScript landscape for either far
too long, or had only barely gone over basic computing concepts. Their
understanding of computers largely ended at “and then v8 does some stuff”.It
was weird cause this person had an honours level computer science degree from
a very prestigious university and they were not from some rich family that
could have paid their way through schooling.They also had over a decade of
experience shipping numerous projects. It really threw me for a loop as to
what a software engineer needs to know to succeed at very high levels
professionally.  
---|---|---  
| ![](s.gif)| [](vote?id=37969817&how=up&goto=item%3Fid%3D37967126)| [robertlagrant](user?id=robertlagrant) [on Oct 21, 2023](item?id=37969817) | root | parent | next [[–]](javascript:void\(0\))  
> and they were not from some rich family that could have paid their way
> through schoolingHuh? If they'd got private tutoring, that wouldn't make
> them understand things any less?  
---|---|---  
| ![](s.gif)| [](vote?id=37970811&how=up&goto=item%3Fid%3D37967126)| [harry8](user?id=harry8) [on Oct 21, 2023](item?id=37970811) | root | parent | next [[–]](javascript:void\(0\))  
The suggestion is that they got there on merit, intelligence, hard work. Not
family influence, money, low key corruption in support of the academic career
of an idiot.  
---|---|---  
| ![](s.gif)| [](vote?id=37983024&how=up&goto=item%3Fid%3D37967126)| [robertlagrant](user?id=robertlagrant) [on Oct 23, 2023](item?id=37983024) | root | parent | next [[–]](javascript:void\(0\))  
It just seems like a very low resolution view of the world. Getting through on
family influence is vanishingly rare, to my understanding.  
---|---|---  
| ![](s.gif)| [](vote?id=37993239&how=up&goto=item%3Fid%3D37967126)| [harry8](user?id=harry8) [on Oct 23, 2023](item?id=37993239) | root | parent | next [[–]](javascript:void\(0\))  
George W. Bush. Hilary Clinton.Legacy admissions exist.There are of course a
million other ways people fail upwards.  
---|---|---  
| ![](s.gif)| [](vote?id=37968918&how=up&goto=item%3Fid%3D37967126)| [yieldcrv](user?id=yieldcrv) [on Oct 21, 2023](item?id=37968918) | root | parent | prev | next [[–]](javascript:void\(0\))  
> I was coming up under a senior at my work one day> It really threw me for a
> loop as to what a software engineer needs to know to succeed at very high
> levels professionallyhe is arguably more successful while you have
> prematurely optimizeddo things that make money, since that’s clearly the
> priority and context here  
---|---|---  
| ![](s.gif)| [](vote?id=37970420&how=up&goto=item%3Fid%3D37967126)| [eropple](user?id=eropple) [on Oct 21, 2023](item?id=37970420) | root | parent | next [[–]](javascript:void\(0\))  
_> he is arguably more successful while you have prematurely optimized_Sure--
until he isn't. And that happens north of "senior".I've had a lot of I-shaped
people reporting to and taking direction from me in my career, and I'm not as
deep at any one thing as many of them. But I'm deep _er_ at a lot of things
than most of those folks, and I can synthesize solutions to more complex
problems because of them. Heck, things I learned writing games in my teens
still come up on occasion twenty years later.  
---|---|---  
| ![](s.gif)| [](vote?id=37970659&how=up&goto=item%3Fid%3D37967126)| [ghosty141](user?id=ghosty141) [on Oct 21, 2023](item?id=37970659) | root | parent | prev | next [[–]](javascript:void\(0\))  
Senior seems to be lacking knowledge that OP has and acts like it. No matter
his backstory he shouldve acknowledged his defieceny. Since OP seems to be
newer in the industry comparing success isnt really fair, he might make it out
on top in the future, we dont know.  
---|---|---  
| ![](s.gif)| [](vote?id=37968205&how=up&goto=item%3Fid%3D37967126)| [dr_kiszonka](user?id=dr_kiszonka) [on Oct 21, 2023](item?id=37968205) | parent | prev | next [[–]](javascript:void\(0\))  
It's not just where you work, in my experience.  
---|---|---  
| ![](s.gif)| [](vote?id=37968906&how=up&goto=item%3Fid%3D37967126)| [dzign](user?id=dzign) [on Oct 21, 2023](item?id=37968906) | parent | prev | next [[–]](javascript:void\(0\))  
Ealier today, a post titled "We have used too many levels of abstraction" was
on HN
top...[https://news.ycombinator.com/item?id=37965142](https://news.ycombinator.com/item?id=37965142)  
---|---|---  
| ![](s.gif)| [](vote?id=37968223&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37968223) | parent | prev | next [[–]](javascript:void\(0\))  
True. It's becoming a lost art. Although, I think anyone who takes a CS
program probably learns enough about CPUs in a Computer Organization or
Computer Architecture course. Even if they never have to use that knowledge
ever again. :)On the other hand I agree that people who take the non-CS route
may not be that intimately familiar with all the details.  
---|---|---  
| ![](s.gif)| [](vote?id=37968871&how=up&goto=item%3Fid%3D37967126)| [galangalalgol](user?id=galangalalgol) [on Oct 21, 2023](item?id=37968871) | root | parent | next [[–]](javascript:void\(0\))  
What is the non-cs route?  
---|---|---  
| ![](s.gif)| [](vote?id=37968683&how=up&goto=item%3Fid%3D37967126)| [i_am_a_peasant](user?id=i_am_a_peasant) [on Oct 21, 2023](item?id=37968683) | parent | prev | next [[–]](javascript:void\(0\))  
Meh, I was lucky enough to start my career in embedded and stay in it for a
decade before I started delving into higher level stuff. Not everyone is that
lucky to be at the right place right time receive guidance from the right
people.  
---|---|---  
| ![](s.gif)| [](vote?id=37968352&how=up&goto=item%3Fid%3D37967126)| [Rizu](user?id=Rizu) [on Oct 21, 2023](item?id=37968352) | parent | prev | next [[–]](javascript:void\(0\))  
Do you have any recommendations to learn CPUs and Systems well ?, thanks  
---|---|---  
| ![](s.gif)| [](vote?id=37968453&how=up&goto=item%3Fid%3D37967126)| [United857](user?id=United857) [on Oct 21, 2023](item?id=37968453) | root | parent | next [[–]](javascript:void\(0\))  
The Patterson Hennessy computer architecture textbook is the classic and still
the best IMO.  
---|---|---  
| ![](s.gif)| [](vote?id=37968457&how=up&goto=item%3Fid%3D37967126)| [mavelikara](user?id=mavelikara) [on Oct 21, 2023](item?id=37968457) | root | parent | prev | next [[–]](javascript:void\(0\))  
Not the GP, but I recommend reading (or watching lectures based on) the book
“Computer Systems: A Programer’s Perspective.”  
---|---|---  
| ![](s.gif)| [](vote?id=37969278&how=up&goto=item%3Fid%3D37967126)| [jocaal](user?id=jocaal) [on Oct 21, 2023](item?id=37969278) | root | parent | prev | next [[–]](javascript:void\(0\))  
Onur Mutlu puts his computer architecture lectures on youtube, their really
good.  
---|---|---  
| ![](s.gif)| [](vote?id=37968883&how=up&goto=item%3Fid%3D37967126)| [mackrevinack](user?id=mackrevinack) [on Oct 21, 2023](item?id=37968883) | root | parent | prev | next [[–]](javascript:void\(0\))  
not sure if this is what you have in mind but Code by Charles Petzold might be
worth checking out  
---|---|---  
| ![](s.gif)| [](vote?id=37970162&how=up&goto=item%3Fid%3D37967126)| [MrRolleyes](user?id=MrRolleyes) [on Oct 21, 2023](item?id=37970162) | parent | prev | next [[–]](javascript:void\(0\))  
> A lot of the newer/young employees don’t even seem to have a lot of
> OS/system understanding.This is largely irrelevant to the concept of
> sequential programming.  
---|---|---  
| ![](s.gif)| [](vote?id=37967303&how=up&goto=item%3Fid%3D37967126)| [abhi9u](user?id=abhi9u) [on Oct 21, 2023](item?id=37967303) | prev | next [[–]](javascript:void\(0\))  
Thank you for sharing!  
---|---|---  
| ![](s.gif)| [](vote?id=37970088&how=up&goto=item%3Fid%3D37967126)| [m3kw9](user?id=m3kw9) [on Oct 21, 2023](item?id=37970088) | prev | next [[–]](javascript:void\(0\))  
Never really needed to know this stuff because compiler does all the
translation, but low level programming like training AI would be useful. Is
that a correct assumption?  
---|---|---  
| ![](s.gif)| [](vote?id=37970326&how=up&goto=item%3Fid%3D37967126)| [einpoklum](user?id=einpoklum) [on Oct 21, 2023](item?id=37970326) | prev [[–]](javascript:void\(0\))  
> Most programmers have an intimate understanding of CPUsNot at all. Very few
> programmers have an intimate understanding of CPUs. I'm not one of them, for
> example. And that's without mentioning how most programmers actually write
> Excel scripts, and most of the rest write interpreted code like Javascript
> or Python which is somewhat removed from the CPU.> because they grow up
> writing code for the CPUThere is not really such thing as "The CPU". The
> design space of CPUs is large enough for it to contain quite a variation of
> beasts. For example,> CPUs were designed to execute sequential
> instructionsOriginally, yes, but - one cannot really make this argument
> about CPUs since Dennard scaling hit the wall, and scale-out began in
> earnest.\-----While the mental model is indeed different, hardware-wise, you
> should think of GPUs as CPUs, except that...* You only ever use SIMD
> registers: 32 lanes x 32bit* Large register file (up to 256 SIMD registers)*
> No branch prediction* Predicated execution supported, but no if-then-else
> (sort of).* Very little stack to speak of* ~10x L1 cache latency* A piece of
> L1 "cache" which doesn't cache anything and you can just write to it like
> regular memory.* ~100x L2 cache latency, no coherence, and it's smaller*
> ~100x main memory latency (and no L3)* A bunch of special registers for
> implementing geometric thread & lane indexing.* ~10x memory bandwidth*
> ~5x-10x cores than on a CPU _(numbers are for NVIDIA cards, AMD are slightly
> different; and of course individual cards differ etc.)_ \-----Now take all
> of those hardware differences, and conceive a programming model. What you
> get is the fanciful tale of a "not-like-a-CPU" processor.Programming for the
> CPU, we often do the opposite, i.e. ignore the cores we have, ignore things
> like latency hiding, careful management of what's in registers and what's in
> the cache, and just write naive serial programs.  
---|---|---  
  
  
  
![](s.gif)|  
---  
  
[Guidelines](newsguidelines.html) | [FAQ](newsfaq.html) | [Lists](lists) | [API](https://github.com/HackerNews/API) | [Security](security.html) | [Legal](https://www.ycombinator.com/legal/) | [Apply to YC](https://www.ycombinator.com/apply/) | [Contact](mailto:hn@ycombinator.com)  
  
Search:

