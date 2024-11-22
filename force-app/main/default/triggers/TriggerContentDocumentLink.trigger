trigger TriggerContentDocumentLink on ContentDocumentLink (after insert) {
	// testar esse aqui em 12/nov/2024
	// nao deu boa nas outras Triggers

	System.Debug(' #### estamos na ContentDocumentLink');
    System.Debug(Trigger.new);
    TriggerContentDocumentLinkHandler.createCandidateSummary(Trigger.new); 
}