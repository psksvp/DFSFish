/*
COMP115 A3
My Fish finds its path to target
by pongsak.suvanpong@mq.edu.au 

Copyright (c) 2014, Pongsak Suvanpong
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of 
conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or other 
materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may 
be used to endorse or promote products derived from this software without specific 
prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY 
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
class Fish extends GameObject
{
    Size size = new Size();
    Rectangle body = new Rectangle();
    Rectangle tail = new Rectangle();
    color bodyColor = color(0,200, 100);
    color tailColor = color(200, 0, 100);
    float heading = 0.0;
    
    
    public Fish(float fishWidth, float fishHeight)
    {
        this.size.set(fishWidth, fishHeight);
        //body occupies 70% of width;
        this.body.size.setWidth((float)(0.7 * fishWidth));
        this.body.size.setHieght(fishHeight);
        
        //tail occupies 30% of width;
        this.tail.size.setWidth((float)(0.3 * fishWidth));
        this.tail.size.setHieght(fishHeight);
    }
    
    public void draw()
    {
        Coordinate loc = this.location();
        //body
        ellipseMode(CORNER);
        fill(bodyColor);
        ellipse(loc.X() + (size.width() - body.size().width()), loc.Y(), 
                body.size().width(), body.size().height()); 
        //tail
        fill(tailColor);
        rect(loc.X(), loc.Y(), tail.size().width(), tail.size().height());
    }
    
    public void move()
    {
        this.location().set(this.location().X(), this.location().Y());
    }
    
    public Rectangle bounding()
    {
        Rectangle b = new Rectangle();
        b.set(this.location().X(), this.location().Y(), 
              this.size.width(), this.size.height());
        return b;
    }
}
