package uk.co.ziazoo.parser
{
  public class EitherParser extends AbstractParser
  {
    private var second:IParser;
    private var first:IParser;

    public function EitherParser(first:IParser, second:IParser)
    {
      this.first = first;
      this.second = second;
    }

    override public function parseState(state:IParserState):Result
    {
      var result:Result = first.parseState(state);
      if (result.success)
      {
        return result;
      }
      else
      {
        result = second.parseState(state);

        if (result.success)
        {
          return result
        }
      }
      return new Fault("Both parsers failed");
    }
  }
}
