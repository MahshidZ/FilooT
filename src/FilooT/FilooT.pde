  
  
  import java.awt.event.ComponentAdapter;
  import java.awt.event.ComponentEvent;
  //package Jama.examples;   
  import Jama.*;
  
  int _w, _h, _min_w, _min_h;
  int textXoffset=0;
  int textYoffset=10;
  
  int BorderOffset=30;
  int ButtonLabelW;
  int ButtonLabelH;
 
 int countPic=0;
  
  
  MultialignView _align_view;
  RowMultialignView _row_align_view;
  ColumnMultialignView _column_align_view;
  //int[] _align_view_origin;
  int _align_view_width, _align_view_height;
  
  MatrixView _matrix_view;
  int[] _matrix_view_origin;
  int _matrix_view_width, _matrix_view_height;
  
  PvalueView _pvalue_view;
  int[] _pvalue_view_origin;
  
  GraphView _graph_view;
  TreeView _row_graph_view;
  CorrelationView _column_graph_view;
  int[] _graph_view_origin;
  
  GroupView _group_view;
  int[] _group_view_origin;
  
  int _divider_pos, _divider_pos_max;
  float _left_percentage, _right_percentage;
  boolean _divider_line_selected = false;
  boolean _divider_line_hover = false;
  boolean _right_pressed = false;
  
  void setup() 
  { 
  	// to capture the size of the monitor
  	_w = screen.width-50;
  	_h = screen.height-100;
  statusBarText=new String("");
  
  	// but lets just hardcode this for now
  	_w = min( _w, 1400);
  	_h = min( _h, 750);
  
  	// min width and heigh
  	_min_w = 350;
  	_min_h = 500;
  
  	size( _w, _h, P2D);
  	_pixel_font_8 = createFont( "PFTempestaSeven", 8, false );
  	_pixel_font_8b = createFont( "PFTempestaSeven-Bold", 8, false );
        _pixel_font_6b = createFont( "PFTempestaSeven-Bold", 6, false );
        _pixel_font_4b = createFont( "PFTempestaSeven-Bold", 4, false );
        _pixel_font_2b = createFont( "PFTempestaSeven-Bold", 2, false );
        _pixel_font_4b = createFont( "PFTempestaSeven-Bold", 4, false );
  	_verdana_font_16 = createFont( "Verdana", 20, true );
  	_verdana_font_8 = createFont( "Verdana", 8, true );
  	_verdana_font_30 = createFont( "Verdana", 30, true );
  	sans_15 = createFont("Verdana", 14, true); 
  	sans_10 = createFont("Verdana", 10, true); 
  	ss=createFont("FFScala",9, false);
  	textMode( SCREEN);
  
  	ButtonLabelW=_w/5;
  	ButtonLabelH= 40;
  
  	// read the data
  	readConfigFile( "config_Data.txt" );
  
  	// generate the data views
  	_align_view = new MultialignView();
  	_row_align_view=new RowMultialignView();
  	_column_align_view=new ColumnMultialignView();
  	_align_view_origin = new int[2];
  
  	_matrix_view = new MatrixView();
  	_matrix_view_origin = new int[2];
  
  	_pvalue_view = new PvalueView();
  	_pvalue_view_origin = new int[2];
  
  	_graph_view=new GraphView();
  	_row_graph_view=new TreeView() ;
  	_column_graph_view=new CorrelationView();
  	_graph_view_origin= new int[2];
  
  	_group_view=new GroupView();
  	_group_view_origin= new int[2];
  
  
  	// determine the initial location of the divider
  	_divider_pos_max = 3*WINDOW_BORDER_WIDTH/2 +  _align_view.getMaxWidth();
  	_divider_pos = min(min(_divider_pos_max,_w-_min_w), _w);
  
  	setPercentages();
  	setDimensions();
  
  	// set up for window resizing
  	frame.setResizable(true);
  	frame.addComponentListener(new ComponentAdapter() {
  		public void componentResized(ComponentEvent e) {
  			if(e.getSource()==frame) 
  			{ 
  				_w = max( frame.getWidth(), _min_w*2 );
  				_h = max( frame.getHeight(), _min_h+22 );
  				frame.setSize(_w,_h); 
  				_h -= 22; 
  				_divider_pos = max(min(/*(int)(_left_percentage*(float)_w)*/_divider_pos, min(_divider_pos_max,_w-_min_w)), _min_w);
  				setPercentages();
  				setDimensions();
  
  			}
  		}
  	} 
  			);
  
  }
  
  void setPercentages(){
  	_left_percentage = (float)_divider_pos/(float)_w;
  	_right_percentage = 1.0 - _left_percentage;
  }
  
  void setDimensions(){ 
  	_align_view_origin[0] = 15*WINDOW_BORDER_WIDTH-WINDOW_BORDER_WIDTH/3;
  	_align_view_origin[1] = 8*WINDOW_BORDER_WIDTH;
  
  	_pvalue_view_origin[0] =_align_view_origin[0]+2*GeneralcellWidth;
  	_pvalue_view_origin[1] =_align_view_origin[1]-120;
  
  	_matrix_view_origin[0] =_align_view_origin[0]-((NUM_CHARACTERS+1)*GeneralcellWidth)-10*(NUM_CHARACTERS)-10;
  	_matrix_view_origin[1] = _pvalue_view_origin[1];
  
  	_graph_view_origin[0]= _w-10*GeneralcellWidth-BorderOffset;
  	_graph_view_origin[1]=  _pvalue_view_origin[1] ;
  
  	_group_view_origin[0]= BorderOffset +10 ;
  	_group_view_origin[1]= _pvalue_view_origin[1];   
  }
  
  
  void draw() {      
  	background( BACKGROUND_COLOR );    
  
  	if(rowBased){
  		_align_view=_row_align_view;
  		_align_view._GroupData=database._rowGroups;}
  	else if(!rowBased){
  		_align_view=_column_align_view;
  		_align_view._GroupData=database._columnGroups;}
  
  	//updateUnfilteredStrains();
  	// translate to the origin of the align VIEW
  	pushMatrix();
  	translate( _align_view_origin[0], _align_view_origin[1] );
  	_align_view.render();
  
  	//textFont( _verdana_font_16 );
  	textFont( sans_10 );
  
  	fill( TITLE_COLOR );
  	textAlign( LEFT, BOTTOM );
  	//text( "Multialignment View", _align_view_origin[0]-textXoffset,
  	//_align_view_origin[1]-textYoffset);
  	popMatrix();
  
  	if(rowBased){
  		_matrix_view._GroupData=database._rowGroups;}
  	else if(!rowBased){
  		_matrix_view._GroupData=database._columnGroups;}
  
  	// translate to the origin of the matrix VIEW
  	pushMatrix();
  	translate( _matrix_view_origin[0], _matrix_view_origin[1] );
  	_matrix_view.render();
  
  	textFont( sans_10 );
  	fill( TITLE_COLOR );
  	textAlign( LEFT, BOTTOM );
  	text( "Matrix View", _matrix_view_origin[0]-textXoffset,
  			_matrix_view_origin[1]-textYoffset);
  	popMatrix();
  
  	if(rowBased){
  		_pvalue_view._GroupData=database._rowGroups;}
  	else if(!rowBased){
  		_pvalue_view._GroupData=database._columnGroups;}
  
  	pushMatrix();
  	translate( _pvalue_view_origin[0], _pvalue_view_origin[1] );
  
  	_pvalue_view.render();
  
  	textFont(sans_10 );
  	fill( TITLE_COLOR );
  	textAlign( LEFT, BOTTOM );
  	text( "Pvalue View", _pvalue_view_origin[0]-textXoffset-1*GeneralcellWidth,
  			_pvalue_view_origin[1]-textYoffset);
  
  	popMatrix();
  
  	if(rowBased){
  		_group_view._GroupData=database._rowGroups;}
  	else if(!rowBased){
  		_group_view._GroupData=database._columnGroups;}
  
  
  	pushMatrix();
  	translate( _group_view_origin[0], _group_view_origin[1] );
  	_group_view.render();
  
  	textFont( sans_10 );
  	fill( TITLE_COLOR );
  	textAlign( LEFT, BOTTOM );
  	text( "Group View", _group_view_origin[0]-textXoffset,
  			_group_view_origin[1]-textYoffset);
  	popMatrix();
  
  	if(rowBased){
  		_graph_view=_row_graph_view;
  		_graph_view._GroupData=database._rowGroups;
  	}
  	else if(!rowBased){
  		_graph_view=_column_graph_view;
  		_graph_view._GroupData=database._columnGroups;
  	} 
  	pushMatrix();
  	translate( _graph_view_origin[0], _graph_view_origin[1] );
  	_graph_view.render();
  
  	textFont(sans_10 );
  	fill( TITLE_COLOR );
  	textAlign( LEFT, BOTTOM );
  	text( "Graph View", _graph_view_origin[0]-textXoffset,
  			_graph_view_origin[1]-textYoffset);
  	popMatrix();
  renderBoarder();
  	renderButtons();   
  
  
  pushMatrix();
  
    		stroke( frameColor );
  		strokeWeight(  frameWidth );
  		fill(BACKGROUND_COLOR );
  	translate( 30,_h-40 );
  	rect(10,0, 200,25);
  
  	textFont(sans_10 );
  	fill( 0 );
  	textAlign( LEFT, BOTTOM );
  	text( statusBarText, 45,
  			_h-20);
  	popMatrix();
  
  
  pushMatrix();
  textFont( sans_10 );
  	fill( TITLE_COLOR );
    text("Status bar", 45,
  			_h-40);
  popMatrix();
        
  
  } // draw
  
  
  void renderButtons(){
  	stroke( frameColor );
  	strokeWeight( frameWidth);
  	noFill();
  	rect(BorderOffset,BorderOffset,ButtonLabelW,ButtonLabelH);
  	if(rowBased){
  		stroke( BACKGROUND_COLOR );
  		//strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		//   fill(255);
  		line(BorderOffset,BorderOffset+ButtonLabelH,ButtonLabelW+BorderOffset,BorderOffset+ButtonLabelH);
  	}//if
  
  	fill( 0);
  	//textFont(_pixel_font_8b);
  	textFont( sans_10 );
  	textAlign( LEFT, BOTTOM );
  	text("Row",
  			BorderOffset + ButtonLabelW/3, 
  			BorderOffset+ButtonLabelH/2
  			);
  
  	stroke( frameColor);
  	strokeWeight( frameWidth );
  	noFill();
  	rect(ButtonLabelW+BorderOffset,BorderOffset,ButtonLabelW,ButtonLabelH);
  	if(!rowBased){
  		stroke( BACKGROUND_COLOR );
  		//strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		// fill(255);
  		line(ButtonLabelW+BorderOffset,BorderOffset+ButtonLabelH,ButtonLabelW+BorderOffset+ButtonLabelW,BorderOffset+ButtonLabelH);
  	} //if 
  
  	fill( 0);
  	//textFont(_pixel_font_8b);
  	textFont( sans_10 );
  	textAlign( LEFT, BOTTOM );
  	text("Column",
  			ButtonLabelW+BorderOffset+ ButtonLabelW/3, 
  			BorderOffset + ButtonLabelH/2
  
  			);
  }// Render Row/column Buttons
  
   void  renderBoarder(){
      stroke( frameColor);
  	strokeWeight( frameWidth);
  	noFill();
  line(BorderOffset,BorderOffset+ButtonLabelH,_w-BorderOffset,BorderOffset+ButtonLabelH);
  line(BorderOffset,_h-BorderOffset,_w-BorderOffset,_h-BorderOffset);
  line(BorderOffset,BorderOffset,BorderOffset,_h-BorderOffset);
  
   line(_w-BorderOffset+BorderOffset/3,BorderOffset+ButtonLabelH,_w-BorderOffset+BorderOffset/3,_h-BorderOffset);
      
    }//  renderBoarder
  
  
  
  void mousePressed() {
  	float mx = (float)mouseX;
  	float my = (float)mouseY;
  
  
  	if (mx >= ButtonLabelW+BorderOffset && mx<=ButtonLabelW+ButtonLabelW+BorderOffset && my>= BorderOffset&& my<=BorderOffset + ButtonLabelH ){
    statusBarText="Mode changed to Column";
  		rowBased=false;   
  		selectedGroupIndex=0;   
      _density=0 ;
      Pvalue =1;
      
           	 width_WindowSize=NumberOfVisualizedPositions;
  		 height_WindowSize=NumberOfVisualizedStrains;
  	      
    cellWidth=30;
    cellHeight= cellWidth;
    seqLabelHeight=cellHeight;
    columnLabelWidth=cellWidth;
             		 _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
   selec=null;
      
  	}
  	else  if (mx >= BorderOffset && mx<=ButtonLabelW+BorderOffset && my>= BorderOffset&& my<=BorderOffset + ButtonLabelH ){
  		rowBased=true;  
   statusBarText="Mode changed to Row";
  		selectedGroupIndex=0;   
     _density=0 ;
     Pvalue =1; 
                	 width_WindowSize=NumberOfVisualizedPositions;
  		 height_WindowSize=NumberOfVisualizedStrains;
  	        
   cellWidth=30;
    cellHeight= cellWidth;
    seqLabelHeight=cellHeight;
    columnLabelWidth=cellWidth;
         		 _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
   selec=null;
  	}
  
  	_align_view.PreviousXslider=(float)mouseX- (float)_align_view_origin[0];
  	_align_view.PreviousYslider=(float)mouseY- (float)_align_view_origin[1];
  
  	float x = (float)mouseX- (float)_matrix_view_origin[0];
  	float y = (float)mouseY- (float)_matrix_view_origin[1];
  	_matrix_view.mousePressedInView((int)x,(int)y);
  
  	x = (float)mouseX- (float)_align_view_origin[0];
  	y = (float)mouseY- (float)_align_view_origin[1]; 
  
  	if(x>=0 && x<=_align_view.getViewWidth()+70 && y>=0 && y <=  _align_view.getViewHeight() +150){
  		_align_view.mousePressedInView(x,y);
  	}
  
  
  	x = (float)mouseX- (float)_graph_view_origin[0];
  	y = (float)mouseY- (float)_graph_view_origin[1]; 
  
  	if(x>=0 && x<=_graph_view.getViewWidth() && y>=0 && y <=  _graph_view.getViewHeight()){
  		_graph_view.mousePressedInView(x,y);
  
  	}
  
  	x = (float)mouseX- (float)_group_view_origin[0];
  	y = (float)mouseY- (float)_group_view_origin[1]; 
  
  	if(x>=0 && x<=_group_view.getViewWidth() && y>=0 && y <= _group_view.getViewHeight()){
  		_group_view.mousePressedInView(x,y);
  
  	}
  
  	x = (float)mouseX- (float)_graph_view_origin[0];
  	y = (float)mouseY- (float)_graph_view_origin[1]; 
  
  	if(x>=0 && x<=_graph_view.getViewWidth() && y>=0 && y <= _graph_view.getViewHeight()){
  		_graph_view.mousePressedInView(x,y);
  
  	} 
        x = (float)mouseX- (float)_pvalue_view_origin[0];
  	y = (float)mouseY- (float)_pvalue_view_origin[1]; 
  
    	if(x>=0 && x<=_pvalue_view.getViewWidth() && y>=0 && y <= _pvalue_view.getViewHeight()){
  		_pvalue_view.mousePressedInView(x,y);
  
  	} 
  
  }
  
  void mouseReleased(){
  
  	float	x = (float)mouseX- (float)_graph_view_origin[0];
  	float y = (float)mouseY- (float)_graph_view_origin[1]; 
  
  	if(x>=0 && x<=_graph_view.getViewWidth() && y>=0 && y <= _graph_view.getViewHeight()){
  		_graph_view.mouseReleasedInView(x,y);       
  	}
  }
  
  void mouseMoved() {
  	_divider_line_hover = false; 
  
  	float	x = (float)mouseX- (float)_align_view_origin[0];
  	float y = (float)mouseY- (float)_align_view_origin[1]; 
  
  	if(x>=0 && x<=(_align_view.getViewWidth() + 60) && y>=0 && y <= _align_view.getViewHeight()){
  
  		_align_view.mouseMovedInView(x,y);  
  	}
  
  	x = (float)mouseX- (float)_graph_view_origin[0];
  	y = (float)mouseY- (float)_graph_view_origin[1]; 
  
  	if(x>=0 && x<=_graph_view.getViewWidth() && y>=0 && y <= _graph_view.getViewHeight()){
  		_graph_view.mouseMovedInView(x,y);
  		_align_view.colorLabel();
  
  	}
  
  }
  
  void mouseDragged() {
  
  	float x = (float)mouseX- (float)_pvalue_view_origin[0];
  	float y=(float)mouseY- (float)_pvalue_view_origin[1];
  
  	if( _pvalue_view.mouseDraggedInView(x,y)){
  		_pvalue_view.overPvalueSlider( (int)x, (int)y );
  	}
  
  	x = (float)mouseX- (float)_align_view_origin[0];
  	y = (float)mouseY- (float)_align_view_origin[1];
  	_align_view.overdensitySlider( (int)x, (int)y );
  	_align_view.overXScrollbar( (int)x, (int)y );
  	_align_view.overYScrollbar( (int)x, (int)y );
  
  
  	x = (float)mouseX- (float)_graph_view_origin[0];
  	y = (float)mouseY- (float)_graph_view_origin[1]; 
  
  	if(x>=0 && x<=_graph_view.getViewWidth() && y>=0 && y <= _graph_view.getViewHeight()){
  		_graph_view.mouseDraggedInView(x,y);
  
  	}
  
  }// mouse drag
  
  
  void keyPressed() {
  	_group_view.keyPressedInView();
  
  
  if (key == 'S' || key=='s') {
save("./pics/picture1.png");  // whole screen of program
 }
else if (key == 'l') {   // just a certain part definded by a rect - see reference on rect (x,y,width, height);
countPic++;
String name="Task1_"+Integer.toString(countPic)+".png";

int rightSegmentX=0;
int rightSegmentY=0;
int rightSegmentWidth=_w;
int rightSegmentHeight=_h;

PImage cp = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp.save("../../pics/whole-"+name);


rightSegmentX=_group_view_origin[0]-5;
rightSegmentY=_group_view_origin[1]-25;
rightSegmentWidth=_group_view.getViewWidth()+10;
rightSegmentHeight=_group_view.getViewHeight()+10;

PImage cp2 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp2.save("../../pics/GroupView_"+name);


rightSegmentX=_align_view_origin[0];
rightSegmentY=_align_view_origin[1]-30;
rightSegmentWidth=_align_view.getViewWidth()+100;
rightSegmentHeight=_align_view.getViewHeight()+100;

PImage cp3 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp3.save("../../pics/AlignView-"+name);


rightSegmentHeight=_align_view.getViewHeight()+160;

PImage cp4 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp4.save("../../pics/AlignViewWithSlider-"+name);

rightSegmentX=_align_view_origin[0];
rightSegmentY=_align_view_origin[1]+430;
rightSegmentWidth=_align_view.getViewWidth()-50;
rightSegmentHeight=50;

PImage cp5 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp5.save("../../pics/DensitySlider-"+name);


rightSegmentX=_matrix_view_origin[0]-10;
rightSegmentY=_matrix_view_origin[1]-30;
rightSegmentWidth=_matrix_view.getMaxWidth()+80;
rightSegmentHeight=_matrix_view.getMaxHeight()+95;

PImage cp6 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp6.save("../../pics/MatrixView-"+name);




rightSegmentX=_graph_view_origin[0]-10;
rightSegmentY=_graph_view_origin[1]-30;
rightSegmentWidth=_graph_view.getViewWidth()+20;
rightSegmentHeight=_graph_view.getViewHeight()+40;

PImage cp7 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp7.save("../../pics/GraphView-"+name);



rightSegmentX=_pvalue_view_origin[0]-35;
rightSegmentY=_pvalue_view_origin[1]-35;
rightSegmentWidth=_pvalue_view.getMaxWidth()+190;
rightSegmentHeight=_pvalue_view.getMaxHeight()+155;

PImage cp8 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp8.save("../../pics/PvalueView-"+name);


rightSegmentX=25;
rightSegmentY=_h-55;
rightSegmentWidth=220;
rightSegmentHeight=80;

PImage cp9 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp9.save("../../pics/StatusBar-"+name);


rightSegmentX=10;
rightSegmentY=20;
rightSegmentWidth=600;
rightSegmentHeight=70;

PImage cp10 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp10.save("../../pics/ModeChange-"+name);

rightSegmentX=_matrix_view_origin[0]-10;
rightSegmentY=_matrix_view_origin[1]-30;
rightSegmentWidth=_matrix_view.getMaxWidth()+80+ _align_view.getViewWidth()+100;
rightSegmentHeight=_matrix_view.getMaxHeight()+95 +_align_view.getViewHeight()+100 ;

PImage cp11 = get (rightSegmentX, rightSegmentY, rightSegmentWidth, rightSegmentHeight);
cp11.save("../../pics/ALignMatrix-"+name);




}

else if (key == 'p') {   
  
saveFrame("../../pics/line-######.png");
saveFrame("../../pics/line-######.jpg");

}
  
  }
  
  

