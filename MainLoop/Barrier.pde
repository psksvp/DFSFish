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
class Barrier extends GameObject
{
    Size size = new Size();
    
    public Barrier(float w, float h)
    {
        this.size.set(w, h);
    }
    
    public void draw()
    {
        /*
        line(this.location().X(), this.location().Y(), 
             this.location().X() + size.width(),
             this.location().Y() + size.height()); */
                  
        fill(200, 200, 200);
        
        ellipseMode(CORNER);
        float min = min(this.size.width(), this.size.height()) - 5;
        /*
        ellipse(this.location().X(), this.location().Y(),
                min, min);  
              
        rect(this.location().X(), this.location().Y(),
             this.size.width(), this.size.height()); */
        
        rect(this.location().X(), this.location().Y(),
             min, min);
    }
    
    public void move()
    {
    
    }
    
    public Rectangle bounding()
    {
        return new Rectangle(this.location().X(), this.location().Y(),
                             this.size.width(), this.size.height());
    }
}
