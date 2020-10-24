import sys
from pygments.token import Token
from IPython.terminal.prompts import Prompts
from prompt_toolkit.key_binding.vi_state import InputMode, ViState

class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '>>  ')]
    def out_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '')]
    def continuation_prompt_tokens(self, cli=None, width=None):
        return [(Token.Prompt, ('>>  '))]

c.TerminalInteractiveShell.prompts_class = MyPrompt


def get_input_mode(self):
    return self._input_mode

def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 1, InputMode.REPLACE: 3}.get(mode, 5)
    raw = u'\x1b[{} q'.format(shape)
    if hasattr(sys.stdout, '_cli'):
        out = sys.stdout._cli.output.write_raw
    else:
        out = sys.stdout.write
    out(raw)
    sys.stdout.flush()
    self._input_mode = mode


ViState._input_mode = InputMode.INSERT
ViState.input_mode = property(get_input_mode, set_input_mode)
c = get_config()
c.TerminalInteractiveShell.editing_mode = 'vi'
