    
    class Cell
    {
    	boolean _hidden;
    	String _positionLabel;
    	boolean _over;
    	float _information;
    	Vector _charLevels= new Vector();
    	float _Pvalue=1;
    	int _color=130;
    
    	Cell(String posL){  		
    		_positionLabel= posL;
    		_hidden=false;
    		_over =false;
    		_information=0;
    	}
    
    	void setInfo(float inf){
    		_information=inf;
    	}
    
    	float getInfo(){
    		return _information;
    	}
    
    	public boolean equals (Object x) {
    		if (((Cell)x)._positionLabel.equals(_positionLabel)) return true;
    		return false;
    	}
    
    	void setOver(boolean ov){
    		_over=ov;
    	}
    
    	Boolean getOver(){
    		return _over;
    	}
    
    	String getPositionLabel(){
    		return _positionLabel;
    	}
    
    	boolean getVisibility(float dens){
    		if(_hidden ||    (dens > _information)	|| (_Pvalue) > Pvalue )
    			return true;
    		return false;
    	} 
    
    	void setVisibility(boolean visible){
    		_hidden=visible;
    	}
    
    	void setpValue(String p){
    		_Pvalue=new Float(p);  
    	}  
    	void setColor(int p){
    		_color=p;  
    	}
    
    }
    
    
    class Strain
    {
    	String[] _nucleotideData;
    	ArrayList _charactristicsData=new ArrayList();
    	String _id;
    	boolean Isfiltered;        
    
    	Strain(String id, String[] nucs){
    		_id=id;
    		_nucleotideData=new String[nucs.length];
    		for(int i=0;i<_nucleotideData.length;i++){
    			_nucleotideData[i]=nucs[i];
    		}
    		Isfiltered=false;
    	}
    
    	void addCharactristics(String newCharactristics){
    		_charactristicsData.add(newCharactristics);
    	}
    
    	void Filter(){
    		Isfiltered=true;
    	}
    
    	String getNucleotideAt(int index) {
    		return _nucleotideData[index];
    	}
    
    	String getCharactristicsAt(int index) {
    		if(index<_charactristicsData.size())
    			return (String)(_charactristicsData.get(index));
    		else{
    			System.out.println("Charactrstics does not exist");
    			return "";
    		}
    	}  
    
    	String getId(){
    		return _id;
    	}
    
    	public boolean equals (Object x) {
    		if (((Strain)x)._id.equals(_id)) return true;
    		return false;
    	}  
    }
    
    
    class HeaderOrder
    {
    	ArrayList _Columns = new ArrayList();
    	String _type;
    
    	HeaderOrder(String headerType){
    		_type=headerType;
    	}
    
    	void addColumn(String hValue){
    		Cell newHeaderColumn=new Cell(hValue);
    		_Columns.add(newHeaderColumn);
    	}
    
    	void setColumnInformation(int index, float inf){
    		((Cell)(_Columns.get(index))).setInfo(inf);
    	}
    
    	void addColumnInformation(int index){
    		((Cell)(_Columns.get(index))). _information ++;
    	}
    
    	int numberOfVisibleCells(float dens){
    		int no=0;
    		if(_type.equals("NucleotidePositions") && !rowBased){
    			for(int i=0;i<( ((Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).headerSize();i++){
    				if(! isCellFiltered(i,dens)) {
    					no++;
  
}

    }
 
    		}
    
    
       		if(_type.equals("NucleotidePositions") && rowBased){
    			for(int i=0;i<( ((Group)( (database._rowGroups).get(selectedGroupIndex) )).PositionHeader).headerSize();i++){
    				if(! isCellFiltered(i,dens)) {
    					no++;
  
}

    }
 
    		} 
    
    
    
    
    		else if(_type.equals("Sequence Labels")){  /// 0?!!
    //System.out.println("Sequence Labels");
    
    			for(int i=0;i<( ((Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();i++){
    				if(! isCellFiltered(i,dens)) 
    					no++;}
    		}
    		return no ;}
    
    
    	void filterColumn(int index)
    	{
    		((Cell)(_Columns.get(index))).setVisibility(false);
    	}
    	void unFilterColumn(int index)
    	{
    		((Cell)(_Columns.get(index))).setVisibility(true);
    	}
    
    	boolean isCellFiltered(int index, float dens)
    	{
    		if(index < _Columns.size() && index >=0){
      //System.out.println(((Cell)(_Columns.get(index))).getVisibility(dens));
    			return ((Cell)(_Columns.get(index))).getVisibility(dens);
    		}
    		else{
    			// System.out.println("Index greater than Column Size!");
    			return false;
    		}
    	}
    
    	String getHeader(int index){
    		//if(!rowBased){
    		return  ((Cell)(_Columns.get(index))).getPositionLabel();
    		// }
    		//  		else{
    		//  
    		//  			return  ((Cell)(_Columns.get(index))).getSequenceLabel();
    		//  		}
    	}
    
    	float getpValue(int index){
    		return  ((Cell)(_Columns.get(index)))._Pvalue;
    
    	}
    
    	int getIndex(String header){
    
    		//if(_Columns.contains(new Cell(header))){
    
    		return _Columns.indexOf(new Cell(header));
    		//  }
    		//else{
    		//System.out.println(header + "does not exist");
    		//return -1;
    		//}
    
    	}
    
    	void SortToDefaultPositionOrder(){
    		if(_type.equals("NucleotidePositions"))
    			Collections.sort(_Columns, new CellComparator());
    		// Collections.sort(_Columns, new CellLabelComparator());
    
    	}
    
    	void SortPositionOrderbyPvalue(){ 		
    		Collections.sort(_Columns, new  PvalueComparator());
    	}
    
    
    
    	void SortbyCharactristics(int i){
    		database.SortStrains(i);
    		Collections.sort(_Columns, new CellLabelComparator());
    		if(ascend == true){
    			//Collections. reverseOrder(new _Columns.CellLabelComparator());
    			Collections.reverse(_Columns);
    		}
    
    	}
    
    
    	void setpValue(int i, String p){
    		((Cell)(_Columns.get(i))).setpValue(p);
    
    	}
    
    	int headerSize(){
    		return _Columns.size();
    	}
    
    	int getColor(int index){
    		return  ((Cell)(_Columns.get(index)))._color;
    	}
    }
    
    
    class Group{
    	HeaderOrder  SequenceLabelHeader;
    	HeaderOrder  PositionHeader;
    	int X;
    	int Y;
    
    	Group(){
    		SequenceLabelHeader= new HeaderOrder("Sequence Labels");
    		PositionHeader= new HeaderOrder("NucleotidePositions");
    
    
    		if(rowBased && database._rowGroups.size()>0){
    			for(int i=0;i<(( (Group)( (database._rowGroups).get(0) )).PositionHeader).headerSize();i++)
    				PositionHeader.addColumn((( (Group)( (database._rowGroups).get(0) )).PositionHeader).getHeader(i));
    		}
    		else if(!rowBased && database._columnGroups.size()>0){
    			for(int i=0;i<(( (Group)( (database._columnGroups).get(0) )).SequenceLabelHeader).headerSize();i++)
    				SequenceLabelHeader.addColumn((( (Group)( (database._columnGroups).get(0) )).SequenceLabelHeader).getHeader(i));
    		}
    	}
    
    	void SetXposition(int x){
    		X=x;
    	}
    	void SetYposition(int y){
    		Y=y;
    	}
    
    }//Group
    
    
    class Database
    {
    	ArrayList _data=new ArrayList();  //ArrayList of Strains
    
    	columnRelationData correlations;
    
    	HeaderOrder  CharactristicsHeader= new HeaderOrder("CharactristicsNames");
    	HeaderOrder  OriginalSequenceHeader= new HeaderOrder("OriginalSequence");
    
    	ArrayList _rowGroups= new ArrayList();
    	ArrayList _columnGroups= new ArrayList();
    
    	void addStrain(String id, String[] nucs){
    		Strain newStrain=new Strain(id, nucs);
    		_data.add(newStrain);    
    	}
    
    	void addDiseaseCharactristicsToStrain(String id, String disChar){
    
    		int inx=0;
    		for(int i=0;i<_data.size();i++){
    
    			if(  ( (Strain)(_data.get(i))).getId().equals(id) ){
    
    				inx=i;
    
    				break;            
    
    			}
    
    		}
    
    		( (Strain)(_data.get(inx))).addCharactristics(disChar);      
    		// _data.add(_data.size()-1, _data.get(inx));
    		//_data.remove(index);
    	}
    
    	void SortStrains(int index){
    		SelectedIndex=index;
    		Collections.sort(_data, new LevelComparator());
    	}
    
    	int getIndex(String seqLbl){
    		String[] nucs=new String[1];
    		return  _data.indexOf(new Strain(seqLbl, nucs));
    	} 
    
    	Strain getStrain(int index){
    		return (Strain)_data.get(index);
    	}
    
    	String getNucleotideAtBySeqIndex(int SeqIndex, int posIndex){
    		return ((Strain)_data.get(SeqIndex)).getNucleotideAt(posIndex);
    	}
    
    	String getNucleotideAtBySeqLabel(String SeqL, int posIndex){
    		return ((Strain)_data.get(getIndex( SeqL))).getNucleotideAt(posIndex);
    	}
    }
    
    class PvalueComparator implements Comparator{ // for comparing columns on their p-values
    	public int compare(Object emp1, Object emp2){
    		Cell cell1=(Cell)emp1;
    		Cell cell2=(Cell)emp2;
    		if(cell1._Pvalue <  cell2._Pvalue)
    		{
    			return 1;
    		}
    		if(cell1._Pvalue < cell2._Pvalue)
    		{
    			return -1;
    		}
    		else
    			return 0;
    
    	}
    }
    
    class LevelComparator implements Comparator{  // For comparing Strains on disease charactristics
    
    	public int compare(Object emp1, Object emp2){
    
    		/*
    		 * parameter are of type Object, so we have to downcast it
    		 * to Employee objects 
    		 */
    
    		String emp1Age = ((Strain)emp1).getCharactristicsAt(SelectedIndex);   
    		String emp2Age = ((Strain)emp2).getCharactristicsAt(SelectedIndex);  
    
    
    		if(emp1Age.equals("High")||emp1Age.equals("Resistant")||emp1Age.equals("Major")||emp1Age.equals("Severe"))
    		{
    			return 1;
    		}
    
    		else if(emp2Age.equals("High")||emp2Age.equals("Resistant")||emp2Age.equals("Major")||emp2Age.equals("Severe"))
    		{
    			return -1;
    		}
    		else if(emp1Age.equals("Low")||emp1Age.equals("Susceptible")||emp1Age.equals("Minor")||emp1Age.equals("Mild"))
    		{
    			return -1;
    		}
    		else if(emp2Age.equals("Low")||emp2Age.equals("Susceptible")||emp2Age.equals("Minor")||emp2Age.equals("Mild"))
    		{
    			return 1;
    		}
    
    		else
    			return 0;    
    	}
    
    }
    
    class CellComparator implements Comparator{   // for comparing Cells on position
    
    	public int compare(Object emp1, Object emp2){
    
    		int emp1Age = Integer.parseInt((((Cell)emp1).getPositionLabel()));        
    		int emp2Age = Integer.parseInt((((Cell)emp2).getPositionLabel()));  
    
    		if(emp1Age > emp2Age)
    			return 1;
    		else if(emp1Age < emp2Age)
    			return -1;
    		else
    			return 0;    
    	}
    
    }
    
    
    class CellLabelComparator implements Comparator{   // for comparing Cells on position
    
    	public int compare(Object emp1, Object emp2){
    
    		String emp1Age = ((((Cell)emp1).getPositionLabel()));        
    		String emp2Age = ((((Cell)emp2).getPositionLabel()));  
    
    
    		int one=  database.getIndex( emp1Age) ;
    		int two=  database.getIndex( emp2Age);
    
    		if(one >two)
    			return 1;
    		else if(one < two)
    			return -1;
    		else
    			return 0;    
    	}
    
    }
    
    
    class EachCharacterComparator implements Comparator{  // For comparing Strains on disease charactristics
    
    	public int compare(Object emp1, Object emp2){
    
    		/*
    		 * parameter are of type Object, so we have to downcast it
    		 * to Employee objects 
    		 */
    
    
    		String emp1Age = ((String)emp1);  
    		String emp2Age = ((String)emp2);
    
    
    		if(emp1Age.equals("High")||emp1Age.equals("Resistant")||emp1Age.equals("Major")||emp1Age.equals("Severe"))
    		{
    			return 1;
    		}
    
    		else if(emp2Age.equals("High")||emp2Age.equals("Resistant")||emp2Age.equals("Major")||emp2Age.equals("Severe"))
    		{
    			return -1;
    		}
    		else if(emp1Age.equals("Low")||emp1Age.equals("Susceptible")||emp1Age.equals("Minor")||emp1Age.equals("Mild"))
    		{
    			return -1;
    		}
    		else if(emp2Age.equals("Low")||emp2Age.equals("Susceptible")||emp2Age.equals("Minor")||emp2Age.equals("Mild"))
    		{
    			return 1;
    		}
    
    		else
    			return 0;    
    	}
    
    }
    
    
    class Node {
    	float x, y;
    	float dx, dy;
    	boolean fixed;
    	String label;
    	int count;
    	float nodeValue;
    
    	Node(String label) {
    		this.label = label;
    		//  x = random(_graph_view.getViewWidth())+_graph_view._cellPos[0];
    		//  y = random(_graph_view.getViewHeight())+_graph_view._cellPos[1];
    		x = random(100);
    		y = random(50);    
    	}
    
    	void increment() {
    		count++;
    	}
     void decrement(){
     count--;
     }
    
    	void relax() {
    		float ddx = 0;
    		float ddy = 0;
    		int Nc;
    		if(!rowBased)
    			Nc=columnNodeCount;
    		else{
    			Nc=rowNodeCount;
    		}
    
    		for (int j = 0; j < Nc; j++) {
    			Node n;
    			if(!rowBased){
    				n = columnNodes[j];
    			}
    			else{
    				n = rowNodes[j];
    			}
    			if (n != this) {
    				float vx = x - n.x;
    				float vy = y - n.y;
    				float lensq = vx * vx + vy * vy;
    				if (lensq == 0) {
    					ddx += random(1);
    					ddy += random(1);
    				} else if (lensq < 100*100) {
    					ddx += vx / lensq;
    					ddy += vy / lensq;
    				}
    			}
    		}
    		float dlen = mag(ddx, ddy) / 2;
    		if (dlen > 0) {
    			dx += ddx / dlen;
    			dy += ddy / dlen;
    		}
    	}
    
    
    	void update() {
    		if (!fixed) {      
    			x += constrain(dx, -5, 5);
    			y += constrain(dy, -5, 5);
    
    			x = constrain(x, 10, 290);
    			y = constrain(y, 50,550);
    		}
    		dx /= 2;
    		dy /= 2;
    	}
    
    
    	void render() {
      if(!rowBased){
     // System.out.println("label: " + label + "count: " + count);
      }
      //if (count > 0) {
      
    		fill(nodeColor);
    		if(selec != null){
    			if(selec.label == label){
    				fill(MOUSEOVER);
    			}
    		}
    		stroke(0);
    		strokeWeight(0.5);
    
    		ellipse(x, y, 25, 25);
    		float w = textWidth(label);
    
    		//if (count > w+2) {
    		fill(255);
    		textAlign(CENTER, CENTER);
    		text(label, x+_graph_view_origin[0], y+_graph_view_origin[1]);
    		// }
    	}
    //}
    
    }
    
    
    // Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.
    // Based on the GraphLayout example by Sun Microsystems.
    
    
    class Edge {
    	Node from;
    	Node to;
    	float len;
    	int count;
    	float edgeValue=0;
    
    	Edge(Node from, Node to) {
    		this.from = from;
    		this.to = to;
    		this.len = 50;
    	}
    
    	void increment() {
    		count++;
    	}
       
    	void relax() {
    		float vx = to.x - from.x;
    		float vy = to.y - from.y;
    		float d = mag(vx, vy);
    		if (d > 0) {
    			float f = (len - d) / (d * 3);
    			float dx = f * vx;
    			float dy = f * vy;
    			to.dx += dx;
    			to.dy += dy;
    			from.dx -= dx;
    			from.dy -= dy;
    		}
    	}
    
    	void render(float negativeTo, float negativeFrom, float positiveFrom, float positiveTo) {
      // to.count=0;
    // from.count=0;
    		strokeWeight(max(5,edgeValue*0.9));
    		if(!rowBased){
    			if(edgeValue >= negativeTo && edgeValue <= negativeFrom){
    				stroke(COMPLEMENTED);
    // to.increment();
    // from.increment();
    // System.out.println("COMPLEMENTED"+edgeValue);
}
    			else if (edgeValue >= positiveFrom && edgeValue <= positiveTo){
    				stroke(CORRELATED);
    if(!rowBased){
     // System.out.println("edgeValue: " + edgeValue + " NFrom: " + negativeFrom + " NTo: " + negativeTo +  " Pfrom: " + positiveFrom + " PTo: " + positiveTo );
    }
     // to.increment();
     //from.increment();
      //System.out.println("CORRELATED"+edgeValue);
    			}
    			else{
    				//stroke(BACKGROUND_COLOR);
    //to.decrement();
    //from.decrement();
                        return;
    			}
    		}
    		else if(rowBased){
    			stroke(0);}
    
    		line(from.x, from.y, to.x, to.y);
    	}
    }
     
    class columnRelation{  
    	columnRelation(){
    		columnEdges = new Edge[400];
    		columnNodes = new Node[1450];
    		columnRelationshipTable = new HashMap();
    	}
    
    	void addEdge(String fromLabel, String toLabel, float value) {
    
    		Node from = findNode(fromLabel);
    		Node to = findNode(toLabel);
    		//from.increment();
    		//to.increment();
    
    		for (int i = 0; i < columnEdgeCount; i++) {
    			if (columnEdges[i].from == from && columnEdges[i].to == to && columnEdges[i].edgeValue==(value)) {
    				columnEdges[i].increment();
    				return;
    			}
    		} 
    
    		Edge e = new Edge(from, to);
    		e.edgeValue=value;
    		e.increment();
    		if (columnEdgeCount == columnEdges.length) {
    			columnEdges = (Edge[]) expand(columnEdges);
    		}
    		columnEdges[columnEdgeCount++] = e;
    	}
    
    	Node findNode(String label) {
    		Node n = (Node)columnRelationshipTable.get(label);
    		if (n == null) {
    			return addNode(label);
    		}
    		return n;
    	}
    
    	Node addNode(String label) {
    		Node n = new Node(label);  
    		if (columnNodeCount == columnNodes.length) {
    			columnNodes = (Node[]) expand(columnNodes);
    		}
    		columnRelationshipTable.put(label, n);
    		columnNodes[columnNodeCount++] = n;  
    		return n;
    	}
    
    	void grender(float Nto, float Nfrom, float Pfrom, float Pto) {
    
        		for (int i = 0 ; i < columnNodeCount ; i++) {    
    			//  if((!(( (group)( (database._Groups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))))
    			String label=columnNodes[i].label;
                        Node n = (Node)columnRelationshipTable.get(label);
                        n.count=0;
    		}
       
    		for (int i = 0 ; i < columnEdgeCount ; i++) {
    			columnEdges[i].relax();
    		}
    		for (int i = 0; i < columnNodeCount; i++) {
    			columnNodes[i].relax();
    		}
    		for (int i = 0; i < columnNodeCount; i++) {
    			columnNodes[i].update();
    		}
    		for (int i = 0 ; i < columnEdgeCount ; i++) {
    
    			String label1=columnEdges[i].from.label;
    			String label2=columnEdges[i].to.label;
    			int col1Index=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getIndex(label1);
    			int col2Index=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getIndex(label2);
    			if(col1Index !=-1 && col2Index != -1 ){
    				if(
    						(!(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(col1Index,floor(_density*10)))
    						&&
    
    						(!(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(col2Index,floor(_density*10)))
    						)
    				{
      Node x=columnEdges[i].from;
      Node y=columnEdges[i].to;
 
      if(columnEdges[i].edgeValue >= Nto && columnEdges[i].edgeValue <= Nfrom){
      findNode(x.label).increment();
      findNode(y.label).increment();
       }
    			else if (columnEdges[i].edgeValue >= Pfrom && columnEdges[i].edgeValue <= Pto){
      findNode(x.label).increment();
      findNode(y.label).increment();
       }
 //  else{
      // findNode(x.label).decrement();
       //findNode(y.label).decrement();
    //  }    
      
    	  columnEdges[i].render(Nto,  Nfrom,  Pfrom,  Pto);
    				}
    			}
    		}
    		for (int i = 0 ; i < columnNodeCount ; i++) {    
    			//  if((!(( (group)( (database._Groups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))))
    			String label=columnNodes[i].label;
                        Node n = (Node)columnRelationshipTable.get(label);
    			// System.out.println(label);
    			int colIndex=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getIndex(label);
    			if(colIndex != -1){
    				if((!(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(colIndex,floor(_density*10))))
    				{
     
     if(n.count>0){
    //  System.out.println("label: " + n.label + " count: " + n.count);
    n.render();
     }
    					//columnNodes[i].render();
    //((Node)columnRelationshipTable.get(label)).count >0
    
    				}
    			}
    		}  
    	}
    
    }
    
    class columnRelationData{
    
    	double[][] preparedData;
    	double[][] correlationMatrix;
    	double[][] columnMeans;  
    
    	columnRelationData(int rowNumber, int columnNumber){
    		preparedData=new double[rowNumber][columnNumber];
    		correlationMatrix=new double[columnNumber][columnNumber];
    		columnMeans=new double[columnNumber][1];
    	}  
    
    	double getCorelation(int i, int j){
    		return correlationMatrix[i][j];   
    	}
    
    	double getColumnMean(int columnIndex){
    		return columnMeans[columnIndex][0];   
    	}
    
    	void setColumnMean(int columnIndex, double value){
    		columnMeans[columnIndex][1]=value;   
    	}
    
    	void setCorrelationMatrix(double[][] postData){
    		for(int i=0; i< postData.length; i++){
    			for (int j=0 ; j< postData[i].length ; j++){
    				correlationMatrix[i][j]=postData[i][j];   
    			}
    		}
    	}
    
    	void setPreparedData(int i, int j,double value){
    		preparedData[i][j]=value;      
    	}
    
    	void setMeans(){
    		Matrix data = new Matrix(preparedData); 
    
    	/*	Matrix averageVector=new Matrix( NUM_SEQUENCES, 1, (double)1.0/(double)(NUM_SEQUENCES+1)) ;
    		//columnMeans=(A.transpose().times(B)).getArray();
    		Matrix means=(data.transpose().times(averageVector));
    		// System.out.println(columnMeans[945][0]);
    
    		Matrix replicationArray=new Matrix(NUM_SEQUENCES,1,1);
    		Matrix meanRepl = replicationArray.times(means.transpose());
    		Matrix dataDemean=data.minus(meanRepl);
    
    		Matrix STD=(dataDemean.arrayTimesEquals(dataDemean)).transpose().times(averageVector);//.plus(means.arrayTimesEquals(means).times((double)1.0/(double)(NUM_SEQUENCES+1)));
    		double[][] STDarr=STD.getArray();
    		// System.out.println("variance="+STDarr[780][0]);
    
    		for(int i=0; i<STDarr.length;i++){
    			for(int j=0;j<STDarr[i].length;j++){
    				STDarr[i][j]=sqrt((float)STDarr[i][j]);
    
    			}
    
    		}
    		STD=new Matrix(STDarr);
    		// System.out.println(STDarr[780][0]);
    		Matrix STDrepl=replicationArray.times(STD.transpose());
    		Matrix dataNormalized=dataDemean.arrayRightDivideEquals(STDrepl);
    
    		Matrix meanDivSTD = means.arrayRightDivideEquals(STD);
    
    		Matrix meanDivSTDAllMultiplied = meanDivSTD.times(meanDivSTD.transpose()).times((double)1.0/pow((float)(NUM_SEQUENCES+1),2.0));
    		correlationMatrix=dataNormalized.transpose().times(dataNormalized).getArray();//.times((double)1.0/(double)(NUM_SEQUENCES+1)).plus(meanDivSTDAllMultiplied).getArray();
*/

                


//    		     double minimum = 1000;
//    		     int index_x = -1;
//    		     int index_y = -1;
//    		          for(int i=0; i<correlationMatrix.length;i++){
//    		     for(int j=0;j<correlationMatrix[i].length;j++){
//    		    if(correlationMatrix[i][j] < minimum)
//    		     {
//    		      minimum = correlationMatrix[i][j];
//    		      index_x = i;
//    		       index_y = j;
//    		     }
//    		     }
//    		     }
//    		 System.out.println(index_x + " " + index_y + " " + minimum);
//    		 System.out.println(correlationMatrix[945][841]);
    	}
    
    	void calculateCorrelations(){
    
    		Matrix data = new Matrix(preparedData);     
    		Matrix andMatrix = data.transpose().times(data);
    		Matrix ones = new Matrix(NUM_SEQUENCES, NUM_NUCLEOTIDES, 1);
    		Matrix xorMatrix = data.transpose().times(data.uminus().plus(ones));
    		correlationMatrix = andMatrix.minus(xorMatrix).times((double)1.0/(double)(NUM_SEQUENCES)).getArray();
      //  System.out.println(correlationMatrix[945][841]);
    	}
    
    }
   
    class rowRelation{
    
    	rowRelation(){
    		rowEdges = new Edge[200];
    		rowNodes = new Node[1450];
    		rowRelationshipTable = new HashMap();
    	}
    
    	void addEdge(String fromLabel, String toLabel, float value) {
    
    		Node from = findNode(fromLabel);
    		Node to = findNode(toLabel);
    		from.increment();
    		to.increment();
    
    		for (int i = 0; i < rowEdgeCount; i++) {
    			if (rowEdges[i].from == from && rowEdges[i].to == to && rowEdges[i].edgeValue==(value)) {
    				rowEdges[i].increment();
    				return;
    			}
    		} 
    
    		Edge e = new Edge(from, to);
    		e.edgeValue=value;
    		e.increment();
    		if (rowEdgeCount == rowEdges.length) {
    			rowEdges = (Edge[]) expand(rowEdges);
    		}
    
    		rowEdges[rowEdgeCount++] = e;
    	}
    
    	Node findNode(String label) {
    		Node n = (Node)rowRelationshipTable.get(label);
    		if (n == null) {
    			return addNode(label);
    		}
    		return n;
    	}
        
    	Node addNode(String label) {
    		Node n = new Node(label);  
    		if (rowNodeCount == rowNodes.length) {
    			rowNodes = (Node[]) expand(rowNodes);
    		}
    		rowRelationshipTable.put(label, n);
    		rowNodes[rowNodeCount++] = n;  
    		return n;
    	}
    
    	void grender(float Nto, float Nfrom, float Pfrom, float Pto) {
    		//System.out.println("edgeCount: " + edgeCount + "nodeCount: " + nodeCount );
    		for (int i = 0 ; i < rowEdgeCount ; i++) {
    			rowEdges[i].relax();
    		}
    		for (int i = 0; i < rowNodeCount; i++) {
    			rowNodes[i].relax();
    		}
    		for (int i = 0; i < rowNodeCount; i++) {
    			rowNodes[i].update();
    		}
    		for (int i = 0 ; i < rowEdgeCount ; i++) {
    
    			String label1=rowEdges[i].from.label;
    			String label2=rowEdges[i].to.label;
    			int col1Index=(( (Group)( (database._rowGroups).get(0) )).SequenceLabelHeader).getIndex(label1);
    			int col2Index=(( (Group)( (database._rowGroups).get(0) )).SequenceLabelHeader).getIndex(label2);
    			//  
    			//  System.out.print(col1Index+ " ");
    			//   System.out.println(col2Index);
    			//      System.out.println("");
    
    			if(
    					(!(( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).isCellFiltered(col1Index,floor(_density*10)))
    					&&
    
    					(!(( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).isCellFiltered(col2Index,floor(_density*10)))
    					)
    			{}
    			//{
    
    			rowEdges[i].render(Nto,  Nfrom,  Pfrom,  Pto);
    			//}
    		}
    		for (int i = 0 ; i < rowNodeCount ; i++) {    
    			//  if((!(( (group)( (database._Groups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))))
    			String label=rowNodes[i].label;
    			int rowIndex=(( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(label);
    
    			//if((!(( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).isCellFiltered(rowIndex,floor(_density*10))))
    			//{
    			if(rowIndex !=-1){
    
    				rowNodes[i].render();
    			}
    			//}
    		}
    	}
    }
