
//
// CONFIG FILE
//
void readConfigFile( String file )
{
	String[] rows = loadStrings( file );
	int counter = 0;
	String[] cols;
	ArrayList sequence_files = new ArrayList();
	ArrayList characteristics_files = new ArrayList();
	ArrayList originalSeq_files = new ArrayList();
	ArrayList pValue_files = new ArrayList();
	ArrayList evolution_files = new ArrayList();

	boolean colormap_set = false; 

	while ( counter < rows.length )
	{
		cols = splitTokens( rows[counter] );  

		if ( cols.length == 0 )
		{
		}
		else if ( cols[0].equals("MULTIALIGNED:") )
		{
			sequence_files.add( cols[1] );
		} 
		else if ( cols[0].equals("CHARACTERISTICS:") )
		{
			characteristics_files.add( cols[1] );
		} 
		else if ( cols[0].equals("ORIGINALSEQ:") )
		{
			originalSeq_files.add( cols[1] );
		}
		else if ( cols[0].equals("PVALUE:") )
		{
			pValue_files.add( cols[1] );
		} 
		else if ( cols[0].equals("EVOLUTION:") )
		{
			evolution_files.add( cols[1] );
		} 

		++counter;
	}

	if (!colormap_set) _selected_colormap = COLORMAP_2;

	String _sequenceFileName=(String) (sequence_files.get(0));
	String _originalSeqFileName=(String) (originalSeq_files.get(0));
	String _charactristicsFileName=(String) (characteristics_files.get(0));
	String _pvalueFileName=(String) (pValue_files.get(0));
	String _evolutionFileName=(String) (evolution_files.get(0));

	database=new Database();
	(database._columnGroups).add(new Group());
	(database._rowGroups).add(new Group());

	ReadOriginalSeq(_originalSeqFileName);
	readAlignFile( _sequenceFileName );   
	readCharacterFile(_charactristicsFileName);
	readPvalueFile(_pvalueFileName);
	readEvolutionFile(_evolutionFileName);

	fillColumnRelation();
}

//
// MULTIALIGNED SEQUENCE FILE
//
void readAlignFile( String file )
{
	String[] rows = loadStrings( file );
	String[] cols=new String[NUM_NUCLEOTIDES];
	NUM_SEQUENCES=rows.length/2;
	database.correlations=new columnRelationData(NUM_SEQUENCES,NUM_NUCLEOTIDES);

	String currentLabel="";
	int inSeq=-1;
	for(int k=0;k<rows.length;k++)
	{
		if (rows[k].substring(0,1).equals( ">" ) )
		{
			currentLabel=rows[k].substring(1,rows[k].length());

		}
		else
		{
			inSeq++;
			for(int i=0;i<NUM_NUCLEOTIDES;i++){
				cols[i] = rows[k].substring(i,i+1);
				if(cols[i].equals(originalSeq.getNucleotideAt(i)))
				{
					cols[i]="0";
					(database.correlations).setPreparedData(inSeq,i,0);

				}
				else{
					(database.correlations).setPreparedData(inSeq,i,1);
					(  ( (Group)( (database._columnGroups).get(0) )).PositionHeader     )   .addColumnInformation(i);
					(  ( (Group)( (database._rowGroups).get(0) )).PositionHeader     )   .addColumnInformation(i);
				}

			}
			database.addStrain(currentLabel,cols);  
			(( (Group)( (database._columnGroups).get(0) )).SequenceLabelHeader).addColumn(currentLabel);
			(( (Group)( (database._rowGroups).get(0) )).SequenceLabelHeader).addColumn(currentLabel);

		}
	}

}    

//
// DISEASE CHARACTRITICS FILE
//
void readCharacterFile( String file )
{
	String[] rows = loadStrings( file );
	String charactristicsValue;
	String seqLabel;
	NUM_CHARACTERS = splitTokens(rows[0],",").length-1;

	for(int j=0;j< NUM_SEQUENCES;j++)
	{
		seqLabel=splitTokens(rows[j+1],",")[0];

		for(int i=0;i<NUM_CHARACTERS;i++)
		{
			charactristicsValue=splitTokens(rows[j+1],",")[i+1] ;
			database.addDiseaseCharactristicsToStrain(seqLabel, charactristicsValue);

			String charId=splitTokens(rows[0],",")[i+1];
			database.CharactristicsHeader.addColumn(charId);

			String level=charactristicsValue;

			if(!(        (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels )      .contains(level)   )      )
			{
				((   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels )   .add(level);
			}


		}
	}

}

//
// ReadOriginalSeq
//
void ReadOriginalSeq( String fileName ){

	String[] rows = loadStrings( fileName );
	NUM_NUCLEOTIDES=rows[1].length();
	String[] cols=new String[NUM_NUCLEOTIDES];
	String[] pos=new String[NUM_NUCLEOTIDES];
	for(int i=0;i<NUM_NUCLEOTIDES;i++){
		cols[i] = rows[1].substring(i,i+1);
		pos[i]=Integer.toString(i+1);
	}
	originalSeq=new Strain("original",cols);

	for(int i=0;i<NUM_NUCLEOTIDES;i++){
		( (Group)( (database._columnGroups).get(0) )).PositionHeader.addColumn(Integer.toString(i+1));
		( (Group)( (database._rowGroups).get(0) )).PositionHeader.addColumn(Integer.toString(i+1));
	}

}

//
// PVALUE FILE
//
void  readPvalueFile ( String file ){  

	String[] rows = loadStrings( file );

	for(int i=2;(i<rows.length && i<NUM_NUCLEOTIDES+2);i++){  

		String p= splitTokens(rows[i],",")[1];

		(( (Group)( (database._columnGroups).get(0) )).PositionHeader).setpValue(i-2,p);  
		(( (Group)( (database._rowGroups).get(0) )).PositionHeader).setpValue(i-2,p);  
	}

	//Arrays.sort(pValues, new CellComparator());
}

//
// EVOLTUION FILE
// 

void readEvolutionFile( String file){
	String[] rows = loadStrings( file );
	int numberOfRows=( ((Group)( (database._rowGroups).get(0) )).SequenceLabelHeader).headerSize();
rR=new rowRelation();

	for(int i=0;(i<rows.length);i++){   

		if (rows[i].substring(0,1).equals( ">" ) ) //just to make sure about the format
		{
			String seqLabel=splitTokens(rows[i],",")[0];
			seqLabel=seqLabel.substring(1,seqLabel.length());


			for(int j=1;j<splitTokens(rows[i],",").length;j++)
			{
				String charactristicsValue=splitTokens(rows[i],",")[j] ;  

				rR.addEdge(seqLabel, charactristicsValue,0);

			}

		}//if

	}

}

void fillColumnRelation(){
	// (database.correlations).calculateCorrelations();
        cR=new columnRelation();
// (database.correlations).calculateCorrelations();
//(database.correlations).setMeans();     
 (database.correlations).calculateCorrelations();
	double calculation=1;
	
	String column1="";
	String column2="";
	for(int i=0;i<NUM_NUCLEOTIDES;i++){
  
 		column1=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getHeader(i);
		for(int j=i+1;j<NUM_NUCLEOTIDES;j++){
			column2=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getHeader(j);
			
                       calculation=(database.correlations).correlationMatrix[i][j];
                       
			if(calculation >= CorrelationStart || calculation <= AntiCorrelationStart ){
				cR.addEdge(column1,column2,(float)calculation);
}
//else if (!(calculation > 0.7)){
//cR.addEdge(column1,column2,-0.5);
//}
		}
	}

}



