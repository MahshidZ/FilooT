  
  class GraphView
  {
  	int _width, _height;
  	int[] _cellPos;  
  	int _cellWidth, _cellHeight;
  	int _seqLabelWidth, _seqLabelHeight;
  	int _columnLabelWidth=_cellWidth, _columnLabelHeight;
  
  	// slider=filter
  
  	int _density_slider_x,_density_slider_y,_density_slider_w,_density_slider_r;
  	float _density_slider_positive_from,  _density_slider_positive_to,  _density_slider_negative_from,  _density_slider_negative_to;
  
  	boolean x_reachtoMax=false;
  	boolean y_reachtoMax=false;
  	static final int SIDE_PADDING=15;
  
  	int selectedSlider=-1;
  	float Nto,Nfrom,Pto,Pfrom;
  	ArrayList _GroupData;
  
  	GraphView(){
  		_cellWidth=30;
  		_cellHeight=30;
  		_seqLabelWidth=_cellWidth*2;
  		_seqLabelHeight=_cellHeight;
  		_columnLabelWidth=_cellWidth;
  		_columnLabelHeight=_cellHeight-5;
  		_cellPos = new int[2];
  		_GroupData= new ArrayList();
  		_cellPos[0]=_seqLabelWidth+SIDE_PADDING;
  		_cellPos[1]=_columnLabelHeight+SIDE_PADDING;
  		_width=10*_cellWidth;
  		_height=590;
  
  		_density_slider_r=10;
  		_density_slider_x=SIDE_PADDING;
  		_density_slider_y= getViewHeight() - (SIDE_PADDING*2);
  		_density_slider_w= getViewWidth()- 2*SIDE_PADDING;

  		_density_slider_positive_from=(float)_density_slider_w/(float)2+_density_slider_x + (CorrelationStart*_density_slider_w/2);
  
  		_density_slider_positive_to=_density_slider_w+_density_slider_x;
  		_density_slider_negative_from=_density_slider_w/2-5+_density_slider_x+(AntiCorrelationStart*_density_slider_w/2);
                
  		_density_slider_negative_to=_density_slider_x;

  
  		calculateRanges();
  
  	}
  
  	void calculateRanges(){
  		Nto= -1+ (_density_slider_negative_to -_density_slider_x)/ (_density_slider_w/2);
  		Nfrom= - ((_density_slider_w/2)-(_density_slider_negative_from-_density_slider_x)) /(_density_slider_w/2);
  		Pto=(_density_slider_positive_to-(_density_slider_w/2)-_density_slider_x)/(_density_slider_w/2);
  		Pfrom=(float)(_density_slider_positive_from-(_density_slider_w/2))/(float)(_density_slider_w/2);
  	}
  
  	void render(){
  		noStroke();
  		strokeCap(SQUARE);
  		noSmooth();
  		stroke(  frameColor );
  		strokeWeight(  frameWidth );
  		noFill();
  		rect(0,0,  getViewWidth(),getViewHeight());           
  		//
  		// Render buttons
  		//
  		//renderRowButton();
  		//renderColumnButton();         
  
  	}//render
  
  	int getViewWidth(){ 
  		return _width;
  	}
  
  	int getViewHeight(){
  		return _height;
  	}
  
  	void renderRowButton(){
  		stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
  		rect(0,0,getViewWidth()/2,_cellHeight);
  		if(rowBased){
  			stroke( BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			//   fill(255);
  			line(0,_cellHeight,getViewWidth()/2,_cellHeight);
  		}//if
  
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("Rows",
  				_graph_view_origin[0]+ getViewWidth()/6 , 
  				_graph_view_origin[1]+ 20
  				);
  	}
  
  	void renderColumnButton(){
  		stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
  		rect(getViewWidth()/2,0,getViewWidth()/2,_cellHeight);
  		if(!rowBased){
  			stroke( BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			// fill(255);
  			line(getViewWidth()/2,_cellHeight,getViewWidth(),_cellHeight);
  		} //if 
  
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("Columns",
  				_graph_view_origin[0]+ getViewWidth()/6 + getViewWidth()/2, 
  				_graph_view_origin[1]+ 20
  
  				);
  	}
  
  	void mouseMovedInView(float mx, float my){
  	}
  
  	void mousePressedInView( float mx, float my){
  
  		//				if (mx >= getViewWidth()/2 && mx<=getViewWidth() && my>= 0&& my<=_cellHeight ){
  		//					rowBased=false;    
  		//
  		//					selectedGroupIndex=0;
  		//
  		//				}
  		//				else if (mx >= 0 && mx<=getViewWidth()/2 && my>= 0&& my<=_cellHeight ){
  		//					rowBased=true;     
  		//					selectedGroupIndex=0;
  		//
  		//				}
  
  		if(rowBased==false){  
  
  			//cR.mousePressedInView(mx,my);
  
  			if(my<= _density_slider_y +15 && my >= _density_slider_y -15 ){
  				if(_density_slider_negative_to-15  < mx && _density_slider_negative_to+15  > mx ){
  					selectedSlider=0;      
  				}         
  				else if(_density_slider_negative_from-15  < mx && _density_slider_negative_from+15  > mx ){
  					selectedSlider=1;      
  				}
  				else if(_density_slider_positive_from-15  < mx && _density_slider_positive_from+15  > mx ){
  					selectedSlider=2;      
  				}
  				else if(_density_slider_positive_to-15  <= mx &&  _density_slider_positive_to+15  >= mx ){
  					selectedSlider=3;      
  
  				}
  			}
  		} //if Column based just for the sliders
  
  	}
  
  	void mouseDraggedInView(float mx, float my){
  		if(rowBased==false){  
  			overDensitySlider( mx, my );
  		}
  
  	}
  
  	void mouseReleasedInView(float mx, float my){
  		if(rowBased==false){  
  		}
  		else{
  			selectedSlider=-1;                                       
  		}
  	}
  
  	void renderdensitySlider() { 
    
 		strokeWeight( 3 );
  		noFill();
  		stroke( BORDER_COLOR );
  
  		line( _density_slider_x, _density_slider_y-(_density_slider_r/2), _density_slider_x, _density_slider_y+(_density_slider_r/2) ); //left vertical
  		line( _density_slider_x+_density_slider_w/2, _density_slider_y-(_density_slider_r/2), _density_slider_x+_density_slider_w/2, _density_slider_y+(_density_slider_r/2) ); // middle vertical 
  		line( _density_slider_x+_density_slider_w, _density_slider_y-(_density_slider_r/2), _density_slider_x+_density_slider_w, _density_slider_y+(_density_slider_r/2) ); // right vertical 
  
  		stroke(COMPLEMENTED);
  		//line( _density_slider_x, _density_slider_y, _density_slider_x+_density_slider_w/2, _density_slider_y );
  		stroke( BORDER_COLOR );
  		line( _density_slider_x, _density_slider_y+(_density_slider_r)/2, _density_slider_x+_density_slider_w/2, _density_slider_y+(_density_slider_r)/2);
  		line( _density_slider_x, _density_slider_y-(_density_slider_r)/2, _density_slider_x+_density_slider_w/2, _density_slider_y-(_density_slider_r/2));
  
  		strokeWeight( 8 );
  		line( _density_slider_negative_from-(_density_slider_r/2), _density_slider_y, _density_slider_negative_to+(_density_slider_r/2), _density_slider_y );
  		strokeWeight( 3 );
  
  		stroke(CORRELATED);
  		//line(  _density_slider_x+_density_slider_w/2, _density_slider_y, _density_slider_x+_density_slider_w, _density_slider_y );
  
  		stroke( BORDER_COLOR );
  		line(  _density_slider_x+_density_slider_w/2, _density_slider_y+(_density_slider_r)/2, _density_slider_x+_density_slider_w, _density_slider_y+(_density_slider_r)/2 );
  		line(  _density_slider_x+_density_slider_w/2, _density_slider_y-(_density_slider_r)/2, _density_slider_x+_density_slider_w, _density_slider_y-(_density_slider_r)/2 );
  
  		strokeWeight( 8 );
  		line( _density_slider_positive_from+(_density_slider_r/2), _density_slider_y, _density_slider_positive_to-(_density_slider_r/2), _density_slider_y );
  		strokeWeight( 3 );
  
  		stroke( BORDER_COLOR );
  		fill( CORRELATED);
  		ellipse(_density_slider_positive_from, _density_slider_y, _density_slider_r, _density_slider_r );
  		ellipse( _density_slider_positive_to, _density_slider_y, _density_slider_r, _density_slider_r );
  
  		stroke(COMPLEMENTED);
  		stroke( BORDER_COLOR );
  		fill( COMPLEMENTED);
  		ellipse( _density_slider_negative_from, _density_slider_y, _density_slider_r, _density_slider_r );
  		ellipse( _density_slider_negative_to, _density_slider_y, _density_slider_r, _density_slider_r );
  		fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( "-1", _density_slider_x+_graph_view_origin[0], _density_slider_y+_graph_view_origin[1]+15 );
  		textAlign( LEFT, CENTER ); 
  		text( "1", _density_slider_x+_density_slider_w+_graph_view_origin[0], _density_slider_y+_graph_view_origin[1]+15);
  		text( "0", _density_slider_x+_density_slider_w/2+_graph_view_origin[0], _density_slider_y+_graph_view_origin[1]+15);
  		text( "-0.5", _density_slider_x+_density_slider_w/4+_graph_view_origin[0], _density_slider_y+_graph_view_origin[1]+15);
  		text( "0.5", _density_slider_x+(3*_density_slider_w/4)+_graph_view_origin[0], _density_slider_y+_graph_view_origin[1]+15);
        
    		           stroke( 0 );
  		 		strokeWeight( 1 );
  		 noFill();
  		  		//fill( 130);
                ellipse(_density_slider_positive_from, _density_slider_y, _density_slider_r, _density_slider_r );
  		ellipse( _density_slider_positive_to, _density_slider_y, _density_slider_r, _density_slider_r );
  ellipse( _density_slider_negative_from, _density_slider_y, _density_slider_r, _density_slider_r );
  		ellipse( _density_slider_negative_to, _density_slider_y, _density_slider_r, _density_slider_r );
  	}
  
  //**********************
  
  	boolean overDensitySlider( float x, float y ) {
  		if ( selectedSlider==0 && x>= _density_slider_negative_to && x<= _density_slider_negative_from
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_negative_to=x;
  			
  
  		}else if ( selectedSlider==0 && x>= _density_slider_x && x<= _density_slider_negative_to
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_negative_to=x;
  			
  		}
  		else if ( selectedSlider==1 && x>= _density_slider_negative_from && x<=  _density_slider_x+_density_slider_w/2
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_negative_from=x;
  			
  
  		}else if ( selectedSlider==1 && x>= _density_slider_negative_to && x<= _density_slider_negative_from
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_negative_from=x;
  			
  		}
  		else if ( selectedSlider==2 && x>= _density_slider_positive_from && x<=  _density_slider_positive_to
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_positive_from=x;
  			
  		}else if ( selectedSlider==2 && x>= _density_slider_x+_density_slider_w/2 && x<= _density_slider_positive_from
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_positive_from=x;
  			
  		}
  		else if ( selectedSlider==3 && x>= _density_slider_positive_from && x<=  _density_slider_positive_to
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_positive_to=x;
  			
  
  		}else if ( selectedSlider==3 && x>= _density_slider_positive_to && x<= _density_slider_x+_density_slider_w
  				&& y<= _density_slider_y +15 && y >= _density_slider_y -15 
  				) {
  
  			_density_slider_positive_to=x;
  			
  		}
  		calculateRanges();
  		return false;
  	} //over density slider 
  
  }// super class
  
  class TreeView extends GraphView
  {
  	void render(){
  		super.render();
  		rR.grender(Nto,Nfrom,Pfrom,Pto);
  	}
  
  	void mouseDraggedInView(float mx, float my){
  		super.mouseDraggedInView(mx,my);
  		if (selection != null) {
  			selection.x = mx;
  			selection.y = my;
  		}
  	}
  
  	void mouseReleasedInView(float mx, float my){
  		super.mouseReleasedInView(mx,my);
  		selection = null;
  	}
  	Node selection; 
  	void mousePressedInView(float mx, float my) {
  		super.mousePressedInView(mx,my);
  		// Ignore anything greater than this distance
  		float closest = 20;
  		for (int i = 0; i < rowNodeCount; i++) {
  			Node n = rowNodes[i];
  			float d = dist(mx, my, n.x, n.y);
  			if (d < closest) {
  				selection = n;
  				closest = d;
  			}
  		}
  		if (selection != null) {
  			if (mouseButton == LEFT) {
  				selection.fixed = true;
  			} else if (mouseButton == RIGHT) {
  				selection.fixed = false;
  			}
  		}
  	}
  
  	void mouseMovedInView(float mx, float my){

    if(selec !=null){
  String val=selec.label;
  int in=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(val);
  (  (Cell) 
  							((         (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(in))._color=130;
   selec=null;
}
 
  
  
  		float closest = 20;
  		for (int i = 0; i < rowNodeCount; i++) {
  			Node n = rowNodes[i];
  			float d = dist(mx, my, n.x, n.y);
  			if (d < closest) {
  				selec = n;
  				closest = d;
  			}
  		}                      
  	}
  }
  
  class CorrelationView extends GraphView
  {
  	void render()
  	{
  		super.render();
                renderdensitySlider();
  		cR.grender(Nto,Nfrom,Pfrom,Pto);
  		// correlationRender();		
  	}
  
  	void mousePressedInView(float mx, float my) {
  		super.mousePressedInView(mx,my);
  		// Ignore anything greater than this distance
  		float closest = 20;
  		for (int i = 0; i < columnNodeCount; i++) {
  			Node n = columnNodes[i];
  			float d = dist(mx, my, n.x, n.y);
  			if (d < closest) {
  				selection = n;
  				closest = d;
  			}
  		}
  		if (selection != null) {
  			if (mouseButton == LEFT) {
  				selection.fixed = true;
  			} else if (mouseButton == RIGHT) {
  				selection.fixed = false;
  			}
  		}
  	}
  
  	void mouseDraggedInView(float mx, float my){
  		super.mouseDraggedInView(mx,my);
  		if (selection != null) {
  			selection.x = mx;
  			selection.y = my;
  		}
  	}
  
  	void mouseReleasedInView(float mx, float my){
  		super. mouseReleasedInView(mx,my);
  		selection = null;
  	}
  	void mouseMovedInView(float mx, float my){
  		//selec=null;
  
      if(selec !=null){
  String val=selec.label;
  int in=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getIndex(val);
  (  (Cell) 
  							((         (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(in))._color=130;
   selec=null;
}
 
  
  
  		float closest = 20;
  		for (int i = 0; i < columnNodeCount; i++) {
  			Node n = columnNodes[i];
  			float d = dist(mx, my, n.x, n.y);
  			if (d < closest) {
  				selec = n;
  				closest = d;
  			}
  		}                      
  	}
  
  }
