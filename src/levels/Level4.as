//package levels
//{
//	import blocks.Block;
//	
//	public class Level4 extends Level
//	{
//		public function Level4()
//		{
//			super();
//		}
//		
//		override protected function hardCodeLevel():void
//		{		
//			row1[0] = new Block(40, 285, "DirtTexture");
//			row1[1] = new Block(98, 285, "WaterTexture");
//			row1[2] = new Block(156, 285, "WaterTexture");
//			row1[3] = new Block(214, 285, "DirtTexture");
//			row1[4] = new Block(272, 285, "DirtTexture");
//			row1[5] = new Block(330, 285, "WaterTexture");
//			row1[6] = new Block(388, 285, "DirtTexture");
//			row1[7] = new Block(446, 285, "DirtTexture");
//			row1[8] = new Block(504, 285, "DirtTexture");
//			row1[9] = new Block(562, 285, "WaterTexture");
//			
//			row2[0] = new Block(40, 340, "DirtTexture");
//			row2[1] = new Block(98, 340, "DirtTexture");
//			row2[2] = new Block(156, 340, "DirtTexture");
//			row2[3] = new Block(214, 340, "WaterTexture");
//			row2[4] = new Block(272, 340, "DirtTexture");
//			row2[5] = new Block(330, 340, "DirtTexture");
//			row2[6] = new Block(388, 340, "DirtTexture");
//			row2[7] = new Block(446, 340, "WaterTexture");
//			row2[8] = new Block(504, 340, "DirtTexture");
//			row2[9] = new Block(562, 340, "DirtTexture");
//			
//			row3[0] = new Block(40, 395, "DirtTexture");
//			row3[1] = new Block(98, 395, "WaterTexture");
//			row3[2] = new Block(156, 395, "DirtTexture");
//			row3[3] = new Block(214, 395, "DirtTexture");
//			row3[4] = new Block(272, 395, "DirtTexture");
//			row3[5] = new Block(330, 395, "DirtTexture");
//			row3[6] = new Block(388, 395, "WaterTexture");
//			row3[7] = new Block(446, 395, "DirtTexture");
//			row3[8] = new Block(504, 395, "DirtTexture");
//			row3[9] = new Block(562, 395, "DirtTexture");
//			
//			row4[0] = new Block(40, 450, "WaterTexture");
//			row4[1] = new Block(98, 450, "DirtTexture");
//			row4[2] = new Block(156, 450, "DirtTexture");
//			row4[3] = new Block(214, 450, "DirtTexture");
//			row4[4] = new Block(272, 450, "WaterTexture");
//			row4[5] = new Block(330, 450, "DirtTexture");
//			row4[6] = new Block(388, 450, "DirtTexture");
//			row4[7] = new Block(446, 450, "DirtTexture");
//			row4[8] = new Block(504, 450, "WaterTexture");
//			row4[9] = new Block(562, 450, "DirtTexture");
//			
//			row5[0] = new Block(40, 505, "WaterTexture");
//			row5[1] = new Block(98, 505, "DirtTexture");
//			row5[2] = new Block(156, 505, "DirtTexture");
//			row5[3] = new Block(214, 505, "WaterTexture");
//			row5[4] = new Block(272, 505, "DirtTexture");
//			row5[5] = new Block(330, 505, "WaterTexture");
//			row5[6] = new Block(388, 505, "DirtTexture");
//			row5[7] = new Block(446, 505, "WaterTexture");
//			row5[8] = new Block(504, 505, "DirtTexture");
//			row5[9] = new Block(562, 505, "WaterTexture");
//			
//			row6[0] = new Block(40, 560, "DirtTexture");
//			row6[1] = new Block(98, 560, "DirtTexture");
//			row6[2] = new Block(156, 560, "WaterTexture");
//			row6[3] = new Block(214, 560, "DirtTexture");
//			row6[4] = new Block(272, 560, "DirtTexture");
//			row6[5] = new Block(330, 560, "DirtTexture");
//			row6[6] = new Block(388, 560, "WaterTexture");
//			row6[7] = new Block(446, 560, "DirtTexture");
//			row6[8] = new Block(504, 560, "DirtTexture");
//			row6[9] = new Block(562, 560, "DirtTexture");
//			
//			row7[0] = new Block(40, 615, "DirtTexture");
//			row7[1] = new Block(98, 615, "DirtTexture");
//			row7[2] = new Block(156, 615, "DirtTexture");
//			row7[3] = new Block(214, 615, "DirtTexture");
//			row7[4] = new Block(272, 615, "DirtTexture");
//			row7[5] = new Block(330, 615, "DirtTexture");
//			row7[6] = new Block(388, 615, "DirtTexture");
//			row7[7] = new Block(446, 615, "DirtTexture");
//			row7[8] = new Block(504, 615, "DirtTexture");
//			row7[9] = new Block(562, 615, "DirtTexture");
//			
//			row8[0] = new Block(40, 670, "MagmaTexture");
//			row8[1] = new Block(98, 670, "MagmaTexture");
//			row8[2] = new Block(156, 670, "MagmaTexture");
//			row8[3] = new Block(214, 670, "MagmaTexture");
//			row8[4] = new Block(272, 670, "MagmaTexture");
//			row8[5] = new Block(330, 670, "MagmaTexture");
//			row8[6] = new Block(388, 670, "MagmaTexture");
//			row8[7] = new Block(446, 670, "MagmaTexture");
//			row8[8] = new Block(504, 670, "MagmaTexture");
//			row8[9] = new Block(562, 670, "MagmaTexture");
//			
//			row9[0] = new Block(40, 725, "MagmaTexture");
//			row9[1] = new Block(98, 725, "MagmaTexture");
//			row9[2] = new Block(156, 725, "MagmaTexture");
//			row9[3] = new Block(214, 725, "MagmaTexture");
//			row9[4] = new Block(272, 725, "MagmaTexture");
//			row9[5] = new Block(330, 725, "MagmaTexture");
//			row9[6] = new Block(388, 725, "MagmaTexture");
//			row9[7] = new Block(446, 725, "MagmaTexture");
//			row9[8] = new Block(504, 725, "MagmaTexture");
//			row9[9] = new Block(562, 725, "MagmaTexture");
//			
//			row10[0] = new Block(40, 780, "MagmaTexture");
//			row10[1] = new Block(98, 780, "MagmaTexture");
//			row10[2] = new Block(156, 780, "MagmaTexture");
//			row10[3] = new Block(214, 780, "MagmaTexture");
//			row10[4] = new Block(272, 780, "MagmaTexture");
//			row10[5] = new Block(330, 780, "MagmaTexture");
//			row10[6] = new Block(388, 780, "MagmaTexture");
//			row10[7] = new Block(446, 780, "MagmaTexture");
//			row10[8] = new Block(504, 780, "MagmaTexture");
//			row10[9] = new Block(562, 780, "MagmaTexture");
//		}
//	}
//}