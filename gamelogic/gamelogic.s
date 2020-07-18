INCLUDE "gamelogic/enemylogic.s"

GameLogic:

   ld ix, Enemy_0_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_1_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_2_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_3_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_4_Base_Address
   call GameLogicEnemy

   ret
