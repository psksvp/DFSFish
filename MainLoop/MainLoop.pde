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
final int nBarriers = 35;
final float xCellSize = 40.0f;
final float yCellSize = 30.0f;

Fish aFish;
Barrier[] barriers = new Barrier[nBarriers];

//human controller, yak!!!!
KeyboardController keyboardController = new KeyboardController(); 

//Fish Autopilot
DFSController dfsController = new DFSController(2, 2); 


// functions
void randomizedBarrierAtIndex(int i)
{
    float nCellX = width / xCellSize;
    float nCellY = height / yCellSize;
    int rx = (int)random(3, nCellX - 1);
    int ry = (int)random(0, nCellY);
    float x = xCellSize * rx;
    float y = yCellSize * ry;
    barriers[i].setLocation((float)random(xCellSize, width - xCellSize * 2), 
                            (float)random(0, height - yCellSize * 1.5));
    //barriers[i].setLocation(x, y);
}

void randomizeBarrierLocation()
{
  randomizedBarrierAtIndex(0);
  for(int i = 1; i < nBarriers; i++)
  {
      boolean keepTrying = true;
      while(true == keepTrying)
      {
          randomizedBarrierAtIndex(i);
          for(int j = 0; j < i; j++)
          {
              keepTrying = isGameObjectsColliding(barriers[i], barriers[j]);
              if(true == keepTrying)
              {
                  break;
              }
          }
      }  
  }
  setupAutopilot();
}

void setupAutopilot()
{
    Rectangle goal = new Rectangle(width, 0, width + 100, height);
    dfsController.setup(aFish, barriers, goal);
}

boolean detectCollision()
{
    for(int i = 0; i < nBarriers; i++)
    {
        if(true == isGameObjectsColliding(aFish, barriers[i]))
        {
            return true;
        }
    } 
    return false;
}

void setup()
{
    size(600, 400);
    float nCellX = width / xCellSize;
    float nCellY = height / yCellSize;
    
    aFish = new Fish(xCellSize * 0.7, yCellSize * 0.5);
    //aFish = new Fish(20, 10);
    aFish.setLocation(0, yCellSize * (float) random(2, nCellY));
    for(int i = 0; i < nBarriers; i++)
    {
       barriers[i] = new Barrier(xCellSize, yCellSize); 
    }
    
    randomizeBarrierLocation();
}

void draw()
{
    background(255);

    for(int i = 0; i < nBarriers; i++)
    {
       barriers[i].draw();
    }
    
    aFish.draw();
    dfsController.control(aFish);
    aFish.move();
    
    if(true == detectCollision() || aFish.location().X() + xCellSize >= width)
    {
       randomizeBarrierLocation();
       aFish.setLocation(0, height / 2); 
    }
}

void keyPressed()
{
    keyboardController.control(aFish);
}
